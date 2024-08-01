#include <SFML/Graphics.hpp>

int main() {
    const int size = 10;
    int x[size] = { 1, 2, 3, 4, 5, 6, 7, 13, 9, 10 };
    int y[size] = { 10, 20, 30, 40, 90, 60, 70, 80, 90, 10 };

    sf::RenderWindow window(sf::VideoMode(800, 600), "Graph");

    while (window.isOpen()) {
        sf::Event event;
        while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed)
                window.close();
        }

        window.clear();

        // Рисуем график
        sf::VertexArray lines(sf::LinesStrip, size);
        for (int i = 0; i < size; ++i) {
            lines[i].position = sf::Vector2f(x[i] * 10, 600 - y[i] * 5);
            lines[i].color = sf::Color::Green;
        }

        window.draw(lines);

        window.display();
    }

    return 0;
}