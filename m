Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515133A9F3;
	Sat, 12 Sep 2026 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789247662; cv=none; b=hmxq6G/nJkcKHFHraI1gaVPdrStcxZVDjxOEzfymvv98pfzE+xUqe0F9IzmEdRwe52GHjrfoqcnrnNmg/fXOSJcjRNMPXDPzFLwLNczW0xmiyGNjBvmGMyzayEhzFY9rMmR56L/4BhfJvicq++mjwGPOha/Q2iyKvAWoLEC9F8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789247662; c=relaxed/simple;
	bh=O4Xjrp3WUipsxtIk9jCqAED4vSyEsx3wRpQ/nSkM3QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOKY/F0xB0o35ZvDKMIT4XnD0eFd4pVY8d3+Opq102HYaWn49Ocq366Xc1U8lKDSJRA5Z8W1aYp6BinrJV7L4a+CQ7PPMNO9XGynLGdzKwZj1CHamKZSw/YS844DIBqiMTTEz/YsnQpQm1AqDq7aDXVOKKgO/QFALh9wVMbfigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N53qReGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N53qReGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9F41F00893;
	Sat, 12 Sep 2026 21:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789247660;
	bh=/8//k2tt/DAzpaRSDYkVVEJC0drkQwp8Q2YveHgNVO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N53qReGzBEacqG0KFHEgGPHjZ40KVMKr9Esf+xzdtWIEqd+J56EQYz5Kox6MjxFEW
	 zpqxX4EjeLZs1rlUuRn+pq5DbHIeetnzjoS8P9zCNzA3gq6OdYQJZGAMX6bIc7JDoy
	 4EpZPckk6jYw3bGyGSDoTFtvc58ClGFJe40byLOU9Y/DCP6pd60GIkmH2QRHPrpn5m
	 Dy+Bwu5u8LBgt5xre1asnF8kI3naoQKogFJTxv/S6VxZMeLairz/honP1TMGxGaebx
	 Tdz3yOXUVI6GcxqwVXFpyGEGxPkjtAyfs1b/xxoF1BVToIzXIE6TzgG964O9ug2oJf
	 7hyWIbuk/wNnQ==
Message-ID: <158e15df-f8a0-43a0-9f92-fd4e64b06b1f@kernel.org>
Date: Sat, 12 Sep 2026 23:14:14 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Initial Apple Silicon A18 Pro device trees and
 dt-bindings
To: Yureka Lilian <yureka@cyberchaos.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-watchdog@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/26 18:58, Yureka Lilian wrote:
> Hi,
>
> This series adds initial device trees and dt-bindings for the A18 Pro
> (t8140) SoC and the MacBook Neo (the only Mac using this SoC).
> It only covers a minimal amount of hardware, but is nontheless useful
> for further development work. The hardware added here has remained
> largely unchanged from the earlier generation Apple Silicon Macs.
>
> Similar to the M4 devices, changes to the m1n1 bootloader are required
> to boot Linux on the MacBook Neo.
> Also, SMP boot depends on further patches to avoid WFI and WFIT
> instructions [1][2].
>
> Merge strategy:
>
> Since there are no actual driver changes in this series, we'd prefer to
> merge the dt-bindings changes through the apple-soc tree once Acked by
> the respective maintainers.
>
> Link[1]: https://lore.kernel.org/all/20260804-arm64-idle-param-v3-1-d10f8159062b@cyberchaos.dev/
> Link[2]: https://lore.kernel.org/all/20260811-idreg-override-wfxt-v1-1-1c71228d0719@cyberchaos.dev/
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---

there's a single typo in one commit message, otherwise for the entire 
series:

Reviewed-by: Sven Peter <sven@kernel.org>


Sven

