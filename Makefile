publish-dry:
	pub publish --dry-run

publish:
	pub publish

upgrade-null-safety:
	dart pub upgrade --null-safety
	dart migrate