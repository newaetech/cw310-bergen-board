#define NORITAKE_VFD_WIDTH              112
#define NORITAKE_VFD_HEIGHT             16
#define NORITAKE_VFD_LINES              (NORITAKE_VFD_HEIGHT/8)

//Different classes have different features. In order for the
//library to use these capabilities, the correct class number
//must be given.
//The model class number is the 4 digits after the dash in the
//model number:
//Example
//    Module                Class Number
//    GU140X32F-7000        7000
//    GU140X16G-7040A       7040
//    GU140X16G-7903        7903
#define NORITAKE_VFD_MODEL_CLASS        7000

//The generation of the GU-7000 series module. This is the last
//letter on the model number if present. If this letter is not
//present or 'A', the generation is 0.
//Example
//    Module                Generation
//    GU140X16G-7003           0
//    GU140X16G-7040A          0
//    GU140X16G-7003B         'B'
#define NORITAKE_VFD_GENERATION         0

//Delay time between the Atmel starting and the VFD module being
//initialized. This is necessary to allow the module's controller
//to initialize. This value will vary depend on the power supply
//and hardware setup. 500 ms is more than enough time for the
//module to start up. This delay will only occur the first time
//the CUY_init() or CUY_reset() method is called.
#define NORITAKE_VFD_RESET_DELAY        500