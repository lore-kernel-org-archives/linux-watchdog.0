Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC254EBAD2;
	Thu, 15 Oct 2026 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059796; cv=none; b=H9GulLkfxMzNa3kygznvVFWjVLZ/uPqgnakxEmi0/P6QrCqYAeztBPtQ7sWyff7ktE+0HRSL3cwoI7ngUD9orl/gQ6LxfrYNNquDztAfl8gvtxmlo3bolRGnTMbw1bVr3QVKk1L689hGgrSc0W2jzAPBBcFJJMlikLsDzkNWL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059796; c=relaxed/simple;
	bh=SpnRm0AMxhTrGSA7+v0qTyrOmjyd6AwwUF1dq4mRh9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZtiiXt9JQbrVdOHUYNVzQ2K9dTyb960hpEIP5AzVBDeavaepi4vuVQNTi/beIa72RcySIOAu0Zk8jpnzO8JNtuA70dvp488Kb4PwNYoR3j/awwA//VzJXKcdh13UjKm55YUNnd0dMr8VaZPigALRtakdFmZ9h5wKph4dWhY+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpKJuhE2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpKJuhE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC5C1F000C4;
	Thu, 15 Oct 2026 10:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792059794;
	bh=QjrOPyKV4mebHhduJ8R6cbiM973RHWBbs2BanP1w2ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HpKJuhE2b9umF+oGHGTB+eNRm1wFEcsah3WvhBG959MH+8KeBKVEWBX5D6Sf0zNZ/
	 ixzFqlpxeEr7+AwI8Uzd3NPwCNFwcWEUtfk0NxEYFFWdfwu3W11+eh8+JSpVba2yNK
	 +ZWQC5lmuvka1Mf59DK5dvOcy+KdOA3RbKE4OH8qoKAezBK+PEmSqKiflaexl+h8PQ
	 3klsKvWLz6gZqy3LzEcIXpTJvE8DjqBa/gn3ck44rJRLGMLoRHDhXBGOlvhZ1YS+nQ
	 P2zrWVB22SecGQ4qzBNWAO7PJq9/oRAICgcdWj0J6OtfrkdoTPaCxfFHaC4oA7pCNt
	 b9EfE0uwIh/Nw==
Date: Thu, 15 Oct 2026 12:23:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hector Martin <marcan@marcan.st>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>, 
	Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 07/10] dt-bindings: pinctrl: apple,pinctrl: Add t6041
 compatible
Message-ID: <20261015-gracious-copper-cheetah-1b4deb@quoll>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-7-961edd8d661b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-7-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:14AM +0200, Yureka Lilian wrote:
> The pin controller on the Apple Silicon T604x (M4 Pro/Max) SoCs is
> compatible with t8103. Add "apple,t6041-pinctrl" as SoC specific
> compatible under "apple,t8103-pinctrl".
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

