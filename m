Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778C524B04;
	Fri,  4 Sep 2026 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554105; cv=none; b=jVoEn1oC3fPxVH6JBO3eeZvJdrE/Tg58iH+LC13v8GxdZZ2fBXpUDLW3NnF3FdIobj/Cod7z3L/L1voA0/xAN/wc6/R74dBNhspTS+ph3V1HQkqCrrMSLvNNucAEf0OlpwMDBpHH7O0F86u18Zion0Rx6QRsM2SGkg/T3N7YNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554105; c=relaxed/simple;
	bh=NBuhd1JVCV9q8Xrwv8tbxZnXpsQoJj8w3sgvpfAlDuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGNAp8nvfVaTVnJmjGQcfh6WfQjoK2JP3Jx8dSOvjyQUr8QjB2D0rkbTUagDe/EuRJwvSE72c0nlrnVoZMePUOlAuIkiKx9e6kcsHxpVNmUeeTj3GKKYpnjQ4vnBrXruRN5hoZJBu8bZtDLmgIVtYBodw04YUcOjTZ21GON0OoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGdhCXql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGdhCXql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B6F1F00A3D;
	Fri,  4 Sep 2026 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788554098;
	bh=ByVGAz+j9xe5MWNa9XTv6mxh8KuFnEa40VZnZO+yeb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gGdhCXql4CzLkGf9OGoZbMxcYFfsZbs1FWEpe6J7eEwlo6Jd+U+0Zn7RhNeiGQLIM
	 kR+fGiBDjUED7n84d69bzyFTkU8roW2La5EMgTaMUY5XxZ7klVql8BPsJlfrwRL45L
	 er9JvOoWzJOw4hKz8mF+cELxhlwAomMHUAR3MzNz+mo3M93OtHNZz0YHtidNa56wsJ
	 pnBr0H76J6rDe1pJ2FTrsLzgtcYZhAHCuXwqdrPrDlzOwkZgVES1BHF5fOq7yZ9Alq
	 LFazWdo5EsMriw9DWZwRYYEpQP6WoTd0IvAEcM1Z7Qz+/nL1IfCjTSHRITXzGvu0eY
	 9YX0DgpVqi2Pg==
Message-ID: <027b6019-9a2c-4f3a-8c64-c9836857b471@kernel.org>
Date: Fri, 4 Sep 2026 22:34:51 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: apple: Add minimal MacBook Neo device
 tree
To: Yureka Lilian <yureka@cyberchaos.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-watchdog@vger.kernel.org
References: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
 <20260904-apple-a18-pro-initial-devicetrees-v1-6-0c25401d165d@cyberchaos.dev>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260904-apple-a18-pro-initial-devicetrees-v1-6-0c25401d165d@cyberchaos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


On 04.09.26 21:49, Yureka Lilian wrote:
> Added a device tree for the MacBook Neo, which uses the t8140 SoC
> (A18 Pro) also found in the iPhone 16 Pro.
> 
> The device tree has a minimal set of devices limited to CPU cores,
> interrupt controller, watchdog, serial and framebuffer.
> 
> Using the macOS 26.6.2 iBoot/firmware, the machine reliably boots
> on a single core using the stock kernel.
> Booting with smp requires avoiding the wfi and wfit instructions
> in the idle loop and `delay()` respectively, since those instructions
> cause a loss of architectural state on the secondary cores.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

[...]

> +
> +	memory@800000000 {

this doesn't fit the reg you use below.

> +		device_type = "memory";
> +		reg = <0x100 0 0x2 0>; /* To be filled by loader */
> +	};

[....]

> +
> +		aic: interrupt-controller@301000000 {
> +			compatible = "apple,t8140-aic3", "apple,t8122-aic3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x00000003 0x01000000 0x00000000 0x1cc000>,
> +			      <0x00000003 0x01040000 0x00000000 0x4000>;

please be consistent and use 0x3 and 0x0 here like for the rest.



Sven

