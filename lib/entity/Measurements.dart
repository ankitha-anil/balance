class Measurement {
  final DateTime time;
  final double weight;
  final double waist;
  final double hips;
  final double arms;
  final double thighs;

  Measurement(
      {this.time, this.weight, this.waist, this.hips, this.arms, this.thighs});

  void printElements() {
    print('weight: $weight, time:  $time, hips: $hips, thighs: $thighs');
  }
}
