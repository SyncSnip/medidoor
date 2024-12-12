/*
  Warnings:

  - You are about to drop the column `created_at` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `Product` table. All the data in the column will be lost.
  - You are about to alter the column `price` on the `Product` table. The data in that column could be lost. The data in that column will be cast from `Decimal(10,2)` to `DoublePrecision`.
  - You are about to drop the column `content` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `prodTypeId` on the `Review` table. All the data in the column will be lost.
  - Added the required column `prodId` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Made the column `name` on table `Product` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `productTypeId` to the `Review` table without a default value. This is not possible if the table is not empty.
  - Made the column `rating` on table `Review` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_prodTypeId_fkey";

-- AlterTable
ALTER TABLE "Order" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "prodId" INTEGER NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "Payment" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "created_at",
DROP COLUMN "updated_at",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "price" SET DATA TYPE DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Review" DROP COLUMN "content",
DROP COLUMN "prodTypeId",
ADD COLUMN     "comment" TEXT,
ADD COLUMN     "productTypeId" INTEGER NOT NULL,
ALTER COLUMN "rating" SET NOT NULL,
ALTER COLUMN "rating" SET DEFAULT 0,
ALTER COLUMN "updatedAt" DROP DEFAULT;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_prodId_fkey" FOREIGN KEY ("prodId") REFERENCES "Product"("prodId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_productTypeId_fkey" FOREIGN KEY ("productTypeId") REFERENCES "ProductType"("prodTypeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_prodId_fkey" FOREIGN KEY ("prodId") REFERENCES "Product"("prodId") ON DELETE RESTRICT ON UPDATE CASCADE;
