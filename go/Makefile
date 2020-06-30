
all: clean android ios

android:
	@mkdir -p ../build/android/
	@gomobile bind -v -target=android -o=../build/android/AWMY.aar github.com/ToJen/awmy/tryhttp

ios:
	@mkdir -p ../build/ios/
	@gomobile bind -v -target=ios github.com/ToJen/awmy/tryhttp

clean:
	@rm -Rf ../build/android/
	@rm -Rf ../build/ios

	