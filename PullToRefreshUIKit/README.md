# 🔄 PullToRefreshUIKit – Amazon-style Product Listing in UIKit

This is a reusable UIKit component that implements a product listing page with modern user experience elements. It mimics a simplified Amazon-style layout and includes pull-to-refresh, smooth state transitions, and an empty state view.

---

## ✨ Features

- 🔄 Pull-to-refresh with `UIRefreshControl`
- 🚫 Empty state with image and message when no products are available
- ✨ Smooth fade animation between loading, empty, and filled states
- 🔁 Optional retry button on failure
- 🌐 API integration for live product data
- 🛒 Product cells styled similar to e-commerce listings

---

## 🎥 Demo

Click below to watch the implementation video:

➡️ [Watch PullToRefreshUIKit Demo](https://github.com/username/UIKit-Modular-Components/blob/main/ImplementationVideos/PullToRefreshUIKit.mp4)


---

## 🚀 Getting Started

1. Open the Xcode project.
2. Run the app on a simulator or device.
3. Pull down on the product list to refresh data.
4. Stop the network or clear product data to see the empty state.
5. Tap retry if enabled to refetch data.

---

## 📦 Customization

- **ProductAPIService.swift**: Replace the API URL or logic with your own endpoint.
- **Empty State Image**: Place your custom image in `Resources/Images/` and update the reference.
- **Styling**: Modify `ProductViewCell.swift` to match your design style.

---

## 📌 Notes

- Written entirely in UIKit with zero external dependencies.
- All state transitions (loading, empty, filled) are animated with smooth fading.
- Error handling and retry logic can be extended for better resiliency.

---

## 📃 License

MIT License — feel free to use, modify, and contribute.

---

## 🙋🏻‍♀️ Author

Built with ❤️ by [Sampada](https://github.com/Sampada0808)


