import 'package:flutter/material.dart';

/// Basic category-based layout for the transactions screen.
///
/// Transaction cards are supplied by the caller so their implementation can
/// live in a separate widget file.
class GetTransactionLayout extends StatelessWidget {
	const GetTransactionLayout({
		super.key,
		this.categories = const ['GROCERIES', 'PHARMA', 'AUTO'],
		this.selectedCategory = 'GROCERIES',
		this.onCategorySelected,
		this.transactionCards = const <Widget>[],
	});

	final List<String> categories;
	final String selectedCategory;
	final ValueChanged<String>? onCategorySelected;
	final List<Widget> transactionCards;

	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);

		return Scaffold(
			appBar: AppBar(title: const Text('Despesas por categoria')),
			body: SafeArea(
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						SizedBox(
							height: 62,
							child: ListView.separated(
								padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
								scrollDirection: Axis.horizontal,
								itemCount: categories.length,
								separatorBuilder: (context, index) => const SizedBox(width: 12),
								itemBuilder: (context, index) {
									final category = categories[index];
									final selected = category == selectedCategory;
									return ChoiceChip(
										label: Text(category),
										selected: selected,
										onSelected: onCategorySelected == null
												? null
												: (_) => onCategorySelected!(category),
										selectedColor: theme.colorScheme.primary,
										labelStyle: TextStyle(
											color: selected
													? theme.colorScheme.onPrimary
													: theme.colorScheme.onSurface,
										),
									);
								},
							),
						),
						const Divider(height: 1),
						Expanded(
							child: transactionCards.isEmpty
									? const Center(
											child: Text('Nenhuma transação nesta categoria'),
										)
									: ListView.separated(
											padding: const EdgeInsets.all(16),
											itemCount: transactionCards.length,
											separatorBuilder: (context, index) =>
													const SizedBox(height: 8),
											itemBuilder: (context, index) => transactionCards[index],
										),
						),
					],
				),
			),
		);
	}
}
