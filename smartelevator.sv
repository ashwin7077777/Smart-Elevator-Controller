module elevator_controller(
    input clk,
    input rst,

    input req_floor0,
    input req_floor1,
    input req_floor2,
    input req_floor3,

    output reg [1:0] current_floor,
    output reg moving_up,
    output reg moving_down,
    output reg door_open
);

reg [3:0] requests;

reg [2:0] state;
reg [2:0] next_state;

parameter IDLE       = 3'd0;
parameter MOVE_UP    = 3'd1;
parameter MOVE_DOWN  = 3'd2;
parameter OPEN_DOOR  = 3'd3;
parameter CLOSE_DOOR = 3'd4;

reg [1:0] target_floor;

always @(posedge clk or posedge rst)
begin
    if(rst)
        requests <= 4'b0000;
    else begin
        if(req_floor0) requests[0] <= 1'b1;
        if(req_floor1) requests[1] <= 1'b1;
        if(req_floor2) requests[2] <= 1'b1;
        if(req_floor3) requests[3] <= 1'b1;
    end
end

always @(*)
begin
    target_floor = current_floor;

    if(requests[0]) target_floor = 2'd0;
    else if(requests[1]) target_floor = 2'd1;
    else if(requests[2]) target_floor = 2'd2;
    else if(requests[3]) target_floor = 2'd3;
end

always @(posedge clk or posedge rst)
begin
    if(rst)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*)
begin
    next_state = state;

    case(state)

        IDLE:
        begin
            if(requests != 0)
            begin
                if(target_floor > current_floor)
                    next_state = MOVE_UP;
                else if(target_floor < current_floor)
                    next_state = MOVE_DOWN;
                else
                    next_state = OPEN_DOOR;
            end
        end

        MOVE_UP:
        begin
            if(current_floor == target_floor)
                next_state = OPEN_DOOR;
        end

        MOVE_DOWN:
        begin
            if(current_floor == target_floor)
                next_state = OPEN_DOOR;
        end

        OPEN_DOOR:
            next_state = CLOSE_DOOR;

        CLOSE_DOOR:
        begin
            if(requests != 0)
                next_state = IDLE;
            else
                next_state = IDLE;
        end

        default:
            next_state = IDLE;
    endcase
end

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        current_floor <= 2'd0;
        moving_up <= 0;
        moving_down <= 0;
        door_open <= 0;
    end
    else
    begin

        case(state)

            IDLE:
            begin
                moving_up <= 0;
                moving_down <= 0;
                door_open <= 0;
            end

            MOVE_UP:
            begin
                moving_up <= 1;
                moving_down <= 0;
                door_open <= 0;

                if(current_floor < target_floor)
                    current_floor <= current_floor + 1;
            end

            MOVE_DOWN:
            begin
                moving_up <= 0;
                moving_down <= 1;
                door_open <= 0;

                if(current_floor > target_floor)
                    current_floor <= current_floor - 1;
            end

            OPEN_DOOR:
            begin
                moving_up <= 0;
                moving_down <= 0;
                door_open <= 1;

                requests[current_floor] <= 0;
            end

            CLOSE_DOOR:
            begin
                door_open <= 0;
            end

        endcase
    end
end

endmodule
