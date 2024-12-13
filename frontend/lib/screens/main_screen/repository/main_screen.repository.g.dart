// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_screen.repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mainScreenRepositoryHash() =>
    r'50246ea9bca1704e14b2b87dd8c3576e501524c2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MainScreenRepository
    extends BuildlessAutoDisposeAsyncNotifier<MainScreenState> {
  late final String username;

  FutureOr<MainScreenState> build(
    String username,
  );
}

/// See also [MainScreenRepository].
@ProviderFor(MainScreenRepository)
const mainScreenRepositoryProvider = MainScreenRepositoryFamily();

/// See also [MainScreenRepository].
class MainScreenRepositoryFamily extends Family<AsyncValue<MainScreenState>> {
  /// See also [MainScreenRepository].
  const MainScreenRepositoryFamily();

  /// See also [MainScreenRepository].
  MainScreenRepositoryProvider call(
    String username,
  ) {
    return MainScreenRepositoryProvider(
      username,
    );
  }

  @override
  MainScreenRepositoryProvider getProviderOverride(
    covariant MainScreenRepositoryProvider provider,
  ) {
    return call(
      provider.username,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'mainScreenRepositoryProvider';
}

/// See also [MainScreenRepository].
class MainScreenRepositoryProvider extends AutoDisposeAsyncNotifierProviderImpl<
    MainScreenRepository, MainScreenState> {
  /// See also [MainScreenRepository].
  MainScreenRepositoryProvider(
    String username,
  ) : this._internal(
          () => MainScreenRepository()..username = username,
          from: mainScreenRepositoryProvider,
          name: r'mainScreenRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mainScreenRepositoryHash,
          dependencies: MainScreenRepositoryFamily._dependencies,
          allTransitiveDependencies:
              MainScreenRepositoryFamily._allTransitiveDependencies,
          username: username,
        );

  MainScreenRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.username,
  }) : super.internal();

  final String username;

  @override
  FutureOr<MainScreenState> runNotifierBuild(
    covariant MainScreenRepository notifier,
  ) {
    return notifier.build(
      username,
    );
  }

  @override
  Override overrideWith(MainScreenRepository Function() create) {
    return ProviderOverride(
      origin: this,
      override: MainScreenRepositoryProvider._internal(
        () => create()..username = username,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        username: username,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MainScreenRepository, MainScreenState>
      createElement() {
    return _MainScreenRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MainScreenRepositoryProvider && other.username == username;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MainScreenRepositoryRef
    on AutoDisposeAsyncNotifierProviderRef<MainScreenState> {
  /// The parameter `username` of this provider.
  String get username;
}

class _MainScreenRepositoryProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MainScreenRepository,
        MainScreenState> with MainScreenRepositoryRef {
  _MainScreenRepositoryProviderElement(super.provider);

  @override
  String get username => (origin as MainScreenRepositoryProvider).username;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
