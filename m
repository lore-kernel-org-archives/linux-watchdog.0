Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F682C08D0;
	Sat, 12 Sep 2026 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789247745; cv=none; b=mrtUyAfOEJ/0lTEdoz4NelldG0b9HyUx7xh+gMN5EdkDyRuY2PID2ehcD3fMO6+MAYTACxvyLDUtiHgnloi2Lh9vFU/nM++3wTlWRq4KoOt63nO265diBqmUpuyqWkYFeSTdSDEgki//0WcsxCqiLpHtjF/7MPVpIi0VkWJkD9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789247745; c=relaxed/simple;
	bh=LuIFItOrRGhOTMaXhkdau5gUM0pTBn96EeE+xosV8FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMuTAorKgQvf96dY4/LhPM2NBPEXmuqhlYHj4BiTWDeyXvRzVBSjaGQU62HHr2y74UYA6zlfR6cvR3cxdgXwYhSk80istHjIJ8rUx3AXrizF+bHjy0mDfUs7SlWLVMm35ROSPblsfNLSpLYi9AWNOcsogw9X1D6r6HW1X0fme74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/iGEqod; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/iGEqod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623541F000FF;
	Sat, 12 Sep 2026 21:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789247736;
	bh=0Mh/huTJwam5/F8JzuAR6TpZyhHpFnxSR9MEhdoiU+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h/iGEqodz+ovg9AX5QfDUyIbRTfpiPdzaXsEjjsW1gozSPZrHZeAHt9V4OcRJPhBc
	 tvrYef3NRQPv9r2BkcWa7gGEqAMXq/DHNCMzlQIukKaqpQeaWm1Ynck6GzuzPL6dH+
	 BSThwNXYy5XZX9Z/HkLbHkkTBbHBh1xHTAaXTtLyPA7yoIZQg4T42iB2vpTNAQjzsN
	 1QRTQ+CTN2oYVw2r/lW4KYeiG2MT7SUqdexMkadhaIrQok8ajbkJw7JEA4yMoh43ms
	 OOTPwEfLFCCv7U0JuO5p7PhbQbtlw9VWCNLDyakjKIS0RikRczC5tmV5GuVCIo4agK
	 PB2n9SBXeSvCg==
Message-ID: <5fd92f0d-ec79-4e58-9a10-c135f55531aa@kernel.org>
Date: Sat, 12 Sep 2026 23:15:32 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] dt-bindings: interrupt-controller: apple,aic2: Add
 t8140 compatible
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
References: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
 <20260911-apple-a18-pro-initial-devicetrees-v2-4-08d06cf011d4@cyberchaos.dev>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260911-apple-a18-pro-initial-devicetrees-v2-4-08d06cf011d4@cyberchaos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/26 18:58, Yureka Lilian wrote:
> The Apple t8140 (A18 Pro) SoC uses an AIC3 as interrupt controller, same as
> the M1-M4 SoCs.

AIC3 was introduced with M3, but no need to respin just for this. If I 
end up applying it to the apple-soc tree I'll just fix it then.


Sven
