import 'package:e_auction/src/features/auction_gallery/domain/repository/auction_gallery_repository.dart';

abstract class AuctionGalleryUseCase {
  final AuctionGalleryRepository auctionGalleryRepository;
  AuctionGalleryUseCase(this.auctionGalleryRepository);
}