import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:parte2/componentes/player.dart'; // Asegúrate de importar tu clase Player

class Enemy extends SpriteComponent with CollisionCallbacks {
  late final SpriteAnimation _enemyAnimation; // Animación del enemigo
  final double speed = 50.0; // Velocidad de movimiento del enemigo
  late Player player; // Referencia al jugador
  double life = 100.0; // Vida del enemigo

  // Constructor para inicializar el enemigo con el jugador
  Enemy({required this.player}) {
    position = Vector2(300, 300); // Posición inicial del enemigo
    size = Vector2(32, 32); // Tamaño del enemigo
  }

  @override
  Future<void> onLoad() async {
    _enemyAnimation = await _loadAnimation(); // Carga la animación
    animation = _enemyAnimation; // Establece la animación en el enemigo
    add(RectangleHitbox()); // Añade un hitbox para detectar colisiones
  }

  @override
  void update(double dt) {
    super.update(dt);
    _moveTowardsPlayer(dt); // Llama a la función que mueve al enemigo hacia el jugador
  }

  // Función que mueve al enemigo hacia el jugador
  void _moveTowardsPlayer(double dt) {
    final dx = player.position.x - position.x; // Diferencia en el eje X
    final dy = player.position.y - position.y; // Diferencia en el eje Y

    // Normaliza la dirección para mover al enemigo en línea recta
    final direction = Vector2(dx, dy).normalized();

    // Mueve al enemigo hacia el jugador a la velocidad definida
    position.add(direction * speed * dt);
  }

  // Detecta la colisión entre el enemigo y el jugador
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      life -= 10; // Si el enemigo colisiona con el jugador, le baja vida
      print("Enemy Life: $life");
      // Aquí puedes agregar efectos visuales o sonoros cuando el enemigo colisiona con el jugador
    }
    super.onCollision(intersectionPoints, other); // Llamada a la función de la clase base
  }

}
