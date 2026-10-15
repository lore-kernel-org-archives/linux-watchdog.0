Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAA4DDB27;
	Thu, 15 Oct 2026 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058966; cv=none; b=rt2xBSuJzEHMKl+KcXqzLl0K2jka49ouDwf12MUsrvUDYQFMdktMMnrfmWDa7q2AZpDyozNYHBVqXAUju6HYNLSxkvMzK10FZ3D2tdVjWqwcleF9ukOfeAnu9LOOZkUpdajGeTsimNVZPW5WJwmLmB26MXkBYjQbc6ajl+yp6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058966; c=relaxed/simple;
	bh=l4CNhpGGzfP2v4Fupb9D2643mx3jOn6jyCXex/dXfNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9p2eWOdoSTt5UJpalEZ/18yYvdt7oF09vvn3bjoKULCz2bLLyodqGl1onI7NElQZrABgF//1M3WWoisuVcTWYxkzApKAPKnW5lQjpij+VRPMXbV4HoEScBimuS5zYqsoxUbtS9Lu/TwRtAlU1Tcx4aseVHcyOUlcdRVu2H29yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajhoMSsR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajhoMSsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5489A1F000C4;
	Thu, 15 Oct 2026 10:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058965;
	bh=h9tSjy5btu0nKEVD9uEjSPa7hI+lCWSjDGkfK4yaJpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ajhoMSsRskdZnQj0c0oTEflDaXe1SWo77F2/5Lhxe2oXFVQ4wcXvcj+Xwij5FmbmA
	 A7bAALzGMN8k8MSGD22je2/Qo6KPugVXSSvtD2DEQAgb69dkBQs3cm4BlnXN53xHO3
	 S0qa//6dYPDAczscOVb8RUTIhrRIrqC7fDpIGYIC8A5gDzvfvAMSqakHNt+4fKEaI2
	 mPV/LzrFDxSwPFWeRc66+0PXUDqBxiXZfZGD/kQx7Yaom1wW/gX/BSPewgFJB7vWsZ
	 OmhOOUO4TRnDzv4FtpL/TgdxvYTty6FF3XYiSjF2HHkWUG0U7tgarIv0QPDiO0o9lE
	 NeEJFuHoyzT9g==
Date: Thu, 15 Oct 2026 12:09:20 +0200
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
Subject: Re: [PATCH v2 04/10] dt-bindings: arm: power: apple,pmgr-pwrstate:
 Add t6041 compatible
Message-ID: <20261015-rampant-imported-wildebeest-8a3b0a@quoll>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-4-961edd8d661b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-4-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:11AM +0200, Yureka Lilian wrote:
> The device power state management of the PMGR blocks on the Apple
> silicon M4 Pro/Max SoCs (t604x) is compatible with the M1-M4 SoCs.
> Add "apple,t6041-pmgr-pwrstate" as M4 Pro/Max specific compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

