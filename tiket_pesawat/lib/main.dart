import 'package:flutter/material.dart';

void main() {
  runApp(FlightBookingApp());
}

class FlightBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> flights = [
    {'destination': 'Jakarta to Bali', 'price': 1045000},
    {'destination': 'Jakarta to New  York', 'price': 10200000},
    {'destination': 'Jakarta to Bangkok', 'price': 2801000},
    {'destination': 'Jakarta to Sydney', 'price': 6136000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Penerbangan')),
      body: ListView.builder(
        itemCount: flights.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.8, // Mengatur lebar tombol sesuai layar
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Warna biru untuk tombol
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(
                          destination: flights[index]['destination'],
                          price: flights[index]['price'],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        flights[index]['destination'],
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        'Price: Rp ${flights[index]['price']}',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BookingScreen extends StatefulWidget {
  final String destination;
  final int price;

  BookingScreen({required this.destination, required this.price});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _completeBooking() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            name: '${_firstNameController.text} ${_lastNameController.text}',
            phone: _phoneController.text,
            destination: widget.destination,
            price: widget.price,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pesan Tiket ke ${widget.destination}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Nama Depan'),
                validator: (value) =>
                    value!.isEmpty ? 'Masukkan nama depan' : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Nama Belakang'),
                validator: (value) =>
                    value!.isEmpty ? 'Masukkan nama belakang' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Masukkan nomor telepon' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _completeBooking,
                child: Text('Selesaikan Pemesanan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String destination;
  final int price;

  ConfirmationScreen({
    required this.name,
    required this.phone,
    required this.destination,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pesan Tiket Ke $destination')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Posisikan konten di tengah secara vertikal
          children: [
            Center(
              child: Icon(Icons.check_circle, color: Colors.green, size: 80),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Terima kasih untuk pemesanan tiket anda!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Center(
              // Tambahkan Center di sini
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Atur posisi konten di tengah secara horizontal
                children: [
                  Text('Ticket Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Nama: $name'),
                  Text('Nomor Telepon: $phone'),
                  Text('Flight: $destination'),
                  Text('Harga: Rp $price'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
