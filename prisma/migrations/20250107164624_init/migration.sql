-- CreateTable
CREATE TABLE `empresas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `direccion` VARCHAR(191) NULL,
    `direccionFiscal` VARCHAR(191) NULL,
    `rfc` VARCHAR(191) NOT NULL,
    `razonSocial` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `cp` INTEGER NOT NULL,
    `estado` VARCHAR(191) NOT NULL,
    `pais` VARCHAR(191) NOT NULL,
    `telefono` VARCHAR(191) NOT NULL,
    `logo` VARCHAR(191) NULL,

    UNIQUE INDEX `empresas_rfc_key`(`rfc`),
    UNIQUE INDEX `empresas_email_key`(`email`),
    INDEX `empresas_rfc_idx`(`rfc`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `huertas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `encargado` VARCHAR(191) NOT NULL,
    `estado` VARCHAR(191) NOT NULL,
    `empresaId` INTEGER NOT NULL,

    INDEX `huertas_empresaId_idx`(`empresaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `actividades` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `codigo` INTEGER NOT NULL,
    `estado` BOOLEAN NOT NULL DEFAULT true,
    `itemGastoId` INTEGER NOT NULL,
    `empresaId` INTEGER NOT NULL,

    UNIQUE INDEX `actividades_codigo_key`(`codigo`),
    INDEX `actividades_itemGastoId_idx`(`itemGastoId`),
    INDEX `actividades_empresaId_idx`(`empresaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `centros_costo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `codigoIntegracion` INTEGER NOT NULL,
    `estado` BOOLEAN NOT NULL DEFAULT true,
    `empresaId` INTEGER NOT NULL,
    `usuarioId` INTEGER NOT NULL,

    UNIQUE INDEX `centros_costo_codigoIntegracion_key`(`codigoIntegracion`),
    INDEX `centros_costo_empresaId_idx`(`empresaId`),
    INDEX `centros_costo_usuarioId_idx`(`usuarioId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sectores` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `zonaRiego` VARCHAR(191) NULL,
    `actividades` VARCHAR(191) NULL,
    `fecha` DATETIME(3) NULL,
    `superficie` INTEGER NOT NULL,
    `estado` VARCHAR(191) NOT NULL,
    `cultivo` VARCHAR(191) NOT NULL,
    `actividadId` INTEGER NOT NULL,
    `hurtaId` INTEGER NOT NULL,
    `centroCostoId` INTEGER NOT NULL,

    INDEX `sectores_actividadId_idx`(`actividadId`),
    INDEX `sectores_hurtaId_idx`(`hurtaId`),
    INDEX `sectores_centroCostoId_idx`(`centroCostoId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `proveedores` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `rfc` VARCHAR(191) NOT NULL,
    `codigo` VARCHAR(191) NOT NULL,
    `correoPagos` VARCHAR(191) NULL,
    `numCuenta` VARCHAR(191) NULL,
    `banco` VARCHAR(191) NULL,
    `empresaId` INTEGER NOT NULL,

    UNIQUE INDEX `proveedores_rfc_key`(`rfc`),
    UNIQUE INDEX `proveedores_codigo_key`(`codigo`),
    INDEX `proveedores_empresaId_idx`(`empresaId`),
    INDEX `proveedores_rfc_idx`(`rfc`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contactos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `proveedorId` INTEGER NOT NULL,
    `nombre` VARCHAR(191) NOT NULL,
    `telefono` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NULL,
    `tipoContacto` VARCHAR(191) NOT NULL,

    INDEX `contactos_proveedorId_idx`(`proveedorId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categorias` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombreCategoria` VARCHAR(191) NOT NULL,
    `tipoCategoria` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `categorias_nombreCategoria_key`(`nombreCategoria`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `productos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `codigo` VARCHAR(191) NOT NULL,
    `unidad` VARCHAR(191) NOT NULL,
    `esAgroquimico` BOOLEAN NOT NULL DEFAULT false,
    `inactivo` BOOLEAN NOT NULL DEFAULT false,
    `ingredientesActivos` TEXT NULL,
    `categoriaId` INTEGER NOT NULL,
    `proveedorId` INTEGER NOT NULL,
    `empresaId` INTEGER NOT NULL,

    UNIQUE INDEX `productos_codigo_key`(`codigo`),
    INDEX `productos_categoriaId_idx`(`categoriaId`),
    INDEX `productos_proveedorId_idx`(`proveedorId`),
    INDEX `productos_empresaId_idx`(`empresaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `procesos_compra` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fechaCompra` DATETIME(3) NOT NULL,
    `proveedorId` INTEGER NOT NULL,
    `statusPago` VARCHAR(191) NOT NULL,
    `centroNegocios` VARCHAR(191) NULL,
    `empresaId` INTEGER NOT NULL,

    INDEX `procesos_compra_proveedorId_idx`(`proveedorId`),
    INDEX `procesos_compra_empresaId_idx`(`empresaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ordenes_compra` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `compraId` INTEGER NOT NULL,
    `productoId` INTEGER NOT NULL,
    `cantidad` DECIMAL(10, 2) NOT NULL,
    `precioUnitario` DECIMAL(10, 2) NOT NULL,
    `empresaId` INTEGER NOT NULL,

    INDEX `ordenes_compra_compraId_idx`(`compraId`),
    INDEX `ordenes_compra_productoId_idx`(`productoId`),
    INDEX `ordenes_compra_empresaId_idx`(`empresaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inventarios` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `productoId` INTEGER NOT NULL,
    `almacenId` INTEGER NOT NULL,
    `cantidadActual` DECIMAL(10, 2) NOT NULL,

    INDEX `inventarios_productoId_idx`(`productoId`),
    INDEX `inventarios_almacenId_idx`(`almacenId`),
    UNIQUE INDEX `inventarios_productoId_almacenId_key`(`productoId`, `almacenId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `movimientos_inventario` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `productoId` INTEGER NOT NULL,
    `almacenId` INTEGER NOT NULL,
    `cantidad` DECIMAL(10, 2) NOT NULL,
    `tipoMovimiento` VARCHAR(191) NOT NULL,
    `fecha` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `descripcion` TEXT NULL,

    INDEX `movimientos_inventario_productoId_idx`(`productoId`),
    INDEX `movimientos_inventario_almacenId_idx`(`almacenId`),
    INDEX `movimientos_inventario_fecha_idx`(`fecha`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuarios` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `contrasena` VARCHAR(191) NOT NULL,
    `empresaId` INTEGER NOT NULL,

    UNIQUE INDEX `usuarios_email_key`(`email`),
    INDEX `usuarios_empresaId_idx`(`empresaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `roles` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombreRol` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `roles_nombreRol_key`(`nombreRol`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `permisos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `descripcion` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `permisos_descripcion_key`(`descripcion`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `roles_permisos` (
    `rolId` INTEGER NOT NULL,
    `permisoId` INTEGER NOT NULL,

    INDEX `roles_permisos_permisoId_idx`(`permisoId`),
    PRIMARY KEY (`rolId`, `permisoId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuarios_roles` (
    `usuarioId` INTEGER NOT NULL,
    `rolId` INTEGER NOT NULL,

    INDEX `usuarios_roles_rolId_idx`(`rolId`),
    PRIMARY KEY (`usuarioId`, `rolId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `empleados` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `fechaNacimiento` DATETIME(3) NULL,
    `puesto` VARCHAR(191) NOT NULL,
    `salario` DECIMAL(10, 2) NOT NULL,
    `activo` BOOLEAN NOT NULL DEFAULT true,
    `fechaContratacion` DATETIME(3) NOT NULL,
    `fechaTermino` DATETIME(3) NULL,
    `urlContrato` VARCHAR(191) NULL,
    `empresaId` INTEGER NOT NULL,
    `sectorId` INTEGER NOT NULL,

    INDEX `empleados_empresaId_idx`(`empresaId`),
    INDEX `empleados_sectorId_idx`(`sectorId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `items_gasto` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `actividad` VARCHAR(191) NOT NULL,
    `codigo` VARCHAR(191) NOT NULL,
    `estado` VARCHAR(191) NOT NULL,
    `empresaId` INTEGER NOT NULL,

    UNIQUE INDEX `items_gasto_codigo_key`(`codigo`),
    INDEX `items_gasto_empresaId_idx`(`empresaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `almacenes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `codigo` VARCHAR(191) NOT NULL,
    `nombreBodega` VARCHAR(191) NOT NULL,
    `costea` VARCHAR(191) NOT NULL,
    `inventario` BOOLEAN NOT NULL DEFAULT true,
    `bodegaPetroleo` BOOLEAN NOT NULL DEFAULT false,
    `estado` VARCHAR(191) NOT NULL,
    `empresaId` INTEGER NOT NULL,

    UNIQUE INDEX `almacenes_codigo_key`(`codigo`),
    INDEX `almacenes_empresaId_idx`(`empresaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `clientes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `rfc` VARCHAR(191) NOT NULL,
    `telefono` VARCHAR(191) NULL,
    `direccion` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `empresaId` INTEGER NOT NULL,

    UNIQUE INDEX `clientes_rfc_key`(`rfc`),
    INDEX `clientes_empresaId_idx`(`empresaId`),
    INDEX `clientes_rfc_idx`(`rfc`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ordenes_venta` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `clienteId` INTEGER NOT NULL,
    `fechaVenta` DATETIME(3) NOT NULL,
    `statusPago` VARCHAR(191) NOT NULL,
    `total` DECIMAL(10, 2) NOT NULL,
    `empresaId` INTEGER NOT NULL,

    INDEX `ordenes_venta_clienteId_idx`(`clienteId`),
    INDEX `ordenes_venta_empresaId_idx`(`empresaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `detalles_orden_venta` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ordenVentaId` INTEGER NOT NULL,
    `productoId` INTEGER NOT NULL,
    `cantidad` DECIMAL(10, 2) NOT NULL,
    `precioUnitario` DECIMAL(10, 2) NOT NULL,

    INDEX `detalles_orden_venta_ordenVentaId_idx`(`ordenVentaId`),
    INDEX `detalles_orden_venta_productoId_idx`(`productoId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pagos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `compraId` INTEGER NOT NULL,
    `fechaPago` DATETIME(3) NOT NULL,
    `monto` DECIMAL(10, 2) NOT NULL,
    `metodoPago` VARCHAR(191) NOT NULL,
    `empresaId` INTEGER NOT NULL,

    INDEX `pagos_compraId_idx`(`compraId`),
    INDEX `pagos_empresaId_idx`(`empresaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `facturas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ordenVentaId` INTEGER NOT NULL,
    `fechaFactura` DATETIME(3) NOT NULL,
    `total` DECIMAL(10, 2) NOT NULL,
    `estado` VARCHAR(191) NOT NULL,
    `empresaId` INTEGER NOT NULL,

    INDEX `facturas_ordenVentaId_idx`(`ordenVentaId`),
    INDEX `facturas_empresaId_idx`(`empresaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `auditoria` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `usuarioId` INTEGER NOT NULL,
    `fechaHora` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `accion` VARCHAR(191) NOT NULL,
    `descripcion` TEXT NULL,

    INDEX `auditoria_usuarioId_idx`(`usuarioId`),
    INDEX `auditoria_fechaHora_idx`(`fechaHora`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
