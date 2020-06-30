package tryhttp

import (
	"fmt"
	"io/ioutil"
	"net/http"
)

// Get does a get
func Get(url string) ([]byte, error) {
	client := &http.Client{} // TODO reuse client?
	req, err := http.NewRequest(http.MethodGet, url, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create new request for [%s]: %v", url, err)
	}

	resp, err := client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to do get request to [%s]: %v", url, err)
	}

	return ioutil.ReadAll(resp.Body)
}

// GetLoop does a get in a loop
func GetLoop(url string, count int) error {
	for i := 0; i < count; i++ {
		_, err := Get(url)
		if err != nil {
			return fmt.Errorf("failed to get on iteration [%s]: %v", i, err)
		}
	}
	return nil
}
