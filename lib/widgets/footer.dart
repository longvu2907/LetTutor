import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Contact
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 15,
            children: [
              Text('Chính sách'),
              Text('Điều khoản'),
              Text('Liên hệ'),
            ],
          ),
          const SizedBox(height: 5),

          // Copy right
          Text(
            '© 2021 - Bản quyền của LetTutor. Tất cả các quyền được bảo lưu.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Công ty TNHH LetTutor Việt Nam (MST: 0317003289)',
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            'Trụ sở chính: 9 Đường Số 3, KDC Cityland Park Hills, Phường 10, Quận Gò Vấp, Thành phố Hồ Chí Minh.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          Text(
            'Điện thoại: 0945 337 337',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          Text(
            'Email: hello@lettutor.com',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
