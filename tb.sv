`timescale 1ns/1ps

module elevator_tb;

reg clk;
reg rst;

reg req_floor0;
reg req_floor1;
reg req_floor2;
reg req_floor3;

wire [1:0] current_floor;
wire moving_up;
wire moving_down;
wire door_open;

elevator_controller DUT(
    .clk(clk),
    .rst(rst),

    .req_floor0(req_floor0),
    .req_floor1(req_floor1),
    .req_floor2(req_floor2),
    .req_floor3(req_floor3),

    .current_floor(current_floor),
    .moving_up(moving_up),
    .moving_down(moving_down),
    .door_open(door_open)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;

    req_floor0 = 0;
    req_floor1 = 0;
    req_floor2 = 0;
    req_floor3 = 0;

    #20;
    rst = 0;

    $display("Request Floor 3");

    req_floor3 = 1;
    #10;
    req_floor3 = 0;

    #100;

    $display("Request Floor 1");

    req_floor1 = 1;
    #10;
    req_floor1 = 0;

    #100;

    $display("Request Floor 0");

    req_floor0 = 1;
    #10;
    req_floor0 = 0;

    #100;

    $display("Simulation Completed");
    $finish;
end

initial
begin
    $monitor(
        "Time=%0t Floor=%0d Up=%0b Down=%0b Door=%0b",
        $time,
        current_floor,
        moving_up,
        moving_down,
        door_open
    );
end

initial
begin
    $dumpfile("elevator.vcd");
    $dumpvars(0,elevator_tb);
end

endmodule
