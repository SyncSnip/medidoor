/*
  Warnings:

  - The primary key for the `Product` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `productId` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `productId` on the `Review` table. All the data in the column will be lost.
  - Added the required column `prodTypeId` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `prodId` to the `Review` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_productId_fkey";

-- AlterTable
ALTER TABLE "Product" DROP CONSTRAINT "Product_pkey",
DROP COLUMN "productId",
ADD COLUMN     "prodId" SERIAL NOT NULL,
ADD COLUMN     "prodTypeId" INTEGER NOT NULL,
ALTER COLUMN "name" DROP NOT NULL,
ALTER COLUMN "quantity" SET DATA TYPE TEXT,
ADD CONSTRAINT "Product_pkey" PRIMARY KEY ("prodId");

-- AlterTable
ALTER TABLE "Review" DROP COLUMN "productId",
ADD COLUMN     "prodId" INTEGER NOT NULL,
ADD COLUMN     "prodTypeId" INTEGER,
ALTER COLUMN "rating" DROP NOT NULL;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "isAdmin" BOOLEAN NOT NULL DEFAULT false;

-- CreateTable
CREATE TABLE "ProductType" (
    "prodTypeId" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "typeCode" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ProductType_pkey" PRIMARY KEY ("prodTypeId")
);

-- CreateTable
CREATE TABLE "Payment" (
    "paymentId" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "amount" BIGINT NOT NULL,
    "method" TEXT NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("paymentId")
);

-- CreateTable
CREATE TABLE "Order" (
    "orderId" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Payment_paymentId_key" ON "Payment"("paymentId");

-- CreateIndex
CREATE UNIQUE INDEX "Order_orderId_key" ON "Order"("orderId");

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_prodTypeId_fkey" FOREIGN KEY ("prodTypeId") REFERENCES "ProductType"("prodTypeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_prodTypeId_fkey" FOREIGN KEY ("prodTypeId") REFERENCES "ProductType"("prodTypeId") ON DELETE SET NULL ON UPDATE CASCADE;
