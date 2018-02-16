
static inline void spin()
{
	for (;;){}
}

void _reset_handler()
{
	spin();
}

void _NMI_handler()
{
	spin();
}

void _hard_fault_handler()
{	
	spin();
}

void _memory_management_fault_handler()
{
	spin();
}

void _bus_fault_handler()
{
	spin();
}

void _usage_fault_handler()
{
	spin();
}