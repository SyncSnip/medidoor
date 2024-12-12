/*
  Warnings:

  - You are about to drop the column `productTypeId` on the `Review` table. All the data in the column will be lost.
  - Added the required column `prodTypeId` to the `Review` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_productTypeId_fkey";

-- AlterTable
ALTER TABLE "Review" DROP COLUMN "productTypeId",
ADD COLUMN     "prodTypeId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_prodTypeId_fkey" FOREIGN KEY ("prodTypeId") REFERENCES "ProductType"("prodTypeId") ON DELETE RESTRICT ON UPDATE CASCADE;
