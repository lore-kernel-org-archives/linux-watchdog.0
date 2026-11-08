Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169463;
	b=U7X9Ku1zkgRil1W4ZNY9Lq8HbAhXJWNX1hrshvdeMFYL3u7mIAU5rKzCeE+ZCAOhvgPS
	 Fpofhjm5YllSRKYPnevMB02MQpSC9fk7zu3NzNajo92stXja4kq1pRtYT5sTnhmpASd1P
	 3qEEiV++9x6UM1JxItm6xJZjROeY1xF+xmCHhFavHdr39bovECtZ4qTbN6nSga+jKSYRc
	 OBzMAA7tu0BClVJcn5KCHOVYyflQTyD4aSuxZ43bTHAOIcB/Me/EED1qMshj7aFif/ECt
	 zaqkMXXofu3AvRFJ9wuAmGOYxcK0m9gLK5QhRWE948PNral/sXjhuh+LeWp2iHanevQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169463;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QR9uJVDOQoJGV8Ovz9OfoTgfyZI97RdSj3kd/OCY9aM=;
	b=B1rIZll9OaYZen4ClchHCFK6DtreDHo/cPk9FlDw96foEu/s1fRACQ/sqet6S9NAtGra
	 KrpEnc+y9lfSj5UuBi5+3tAKX9uoCxgsK5hV5KXghiV07xs/K0WSw4VnLJffRmnQTMuGj
	 avKgCDcGqLqo1RgwX6ojIwuCCrAnOJuCwRez9aAPL03AOh01nsO5Hf0Noua9QiVgauLGG
	 Dy5I15xBqWs6UJ8P7dDso7AWNo22Gpfg36zfosgWpWE3+EVmH5gp9D7EftNc5EaGDXihQ
	 E5e6eoAR+SGP7n+3ne5SMc8XiihXMo7CDVLjBqZckdH82EunOkBkeBKekqgdN5Gjyvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRoqPRYT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421260A5BDC;
	Sun,  8 Nov 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRoqPRYT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F661F0089F;
	Sun,  8 Nov 2026 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169463;
	bh=QR9uJVDOQoJGV8Ovz9OfoTgfyZI97RdSj3kd/OCY9aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nRoqPRYT1PvughfnxnZ2jcUyxUshHlKePS5dz9eWxnSlABRBiLKSnmYirtCkpfrNe
	 pvVHGt0jpKqAYOuxaY6LpkVVehfGcqWnn+ANUaer5Bwxw1UefUQ7yG8fq9GdnluufP
	 KEs/XZQrGvhhjlNfpktHFsNvDy5uI7iNI4ffGWRUK2/8MmlUThPRUe1a8oTQX0sphm
	 k/yIx7tqLghUZG6V409riHwySyBCC3G2GMbqUoDfO0pzUgQ4HeT+aPz7xhN/pjXGGA
	 ZgXBg5EG118k1EUH5dv5PKDcKm6L+0NWj543PfJy4U/kNaSGqXTvTE1VwU/kvP3Cew
	 1vAaQ/WhcH3VQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] arm64: dts: qcom: sm8650-valve-deckard: Add watchdog support
Date: Sun,  8 Nov 2026 14:20:57 -0600
Message-ID: <179416929313.628393.4067545467661915449.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002-topic-sm8650-deckard-watchdog-v1-0-7d7f7d71d88a@linaro.org>
References: <20261002-topic-sm8650-deckard-watchdog-v1-0-7d7f7d71d88a@linaro.org>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 02 Oct 2026 11:45:27 +0200, Neil Armstrong wrote:
> This series adds Qualcomm SM8650 watchdog support for the Deckard
> platform by updating both the binding and the SM8650 devicetree.
> 
> The watchdog is marked as reserved by default since most boards
> uses the Gunhyah Hypervisor which owns the watchdog.
> 
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sm8650-valve-deckard: enable the watchdog
      commit: dfb2628e364700ef81926623e468b0cd1e2a6f34

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
