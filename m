Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762F4FE2E2;
	Thu, 15 Oct 2026 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096198; cv=none; b=rEgHsP2yQT7obSUwr1cH9thTBPpQwEYtlZ9n1qSrqbkGoHeZyiJ/0dViXQN3vmCEFML9ml4ZEg7BpO5OmDwc3zm75TSUwT8VZhULzgcgVPbBDUuDmWY4inHOnqhwD5Rv2MmR51VluUw2HnbXgJu5Y4SCnwP2LX2IsJ1c3zwluyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096198; c=relaxed/simple;
	bh=ch7EG77qjowXD41xAEl9Or0RS8Oy8VfIQ8MTG26w4Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dW5gVlnDNyeOPxyJ2vnHq0kmqa2/CdOFN1eTA3Q7Y+GWirQXU+0FFZ2H2sUcl6/+NWaSV6kF9zLx/wnGfZQVAvBvGJjDd13DR+kxyWmUViqwqAAWpiXOvnsOT0dc23Wnw54ofZZVrMOK1ciRcMY+MfIXe2msW9CjOtHy9hkLfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SydBT73Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SydBT73Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BF81F000C4;
	Thu, 15 Oct 2026 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792096196;
	bh=paziipE/XgaTDQwZRgtVHzDUAZZwAvePegn9nlvyFOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SydBT73QOm7ADkQtzSTlALUHTDfIvqukcaSkwd7aHkz0jLCygKgZu2nSIXcsFi1zc
	 ieWRF/jdQ/ru9sBRexMtit3utKEYfZEhPX24n5z9xTi9WI1AAhOW3fLMhbzsr2x9/l
	 Rv25FXKNX0HB2tGMFPd9io+7IaJJW0zisPg8WqwJunWwJmsrokagurzyUrRmDVhEn7
	 c07ctjZXRmn/h8T1otEGBU2WDbFJ1h3zppNywtI974u2iWH5esPOX0iM8vyG2sHPQ7
	 ag6FvCyOrRuVKtBmuPlbw3eVLhpbCgtlKd747tGsoxgZpweUdUolLYpgN1LVj9SKJx
	 oZ1qLt8bUwsdQ==
Date: Thu, 15 Oct 2026 15:29:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 05/11] dt-bindings: i2c: Add Cortina Systems CS7542
 I2C controller
Message-ID: <179209619291.3075035.14291560826684213892.robh@kernel.org>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <20261013-b4-cs75xx-s2-v3-5-181bb0d23f4c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-b4-cs75xx-s2-v3-5-181bb0d23f4c@gmail.com>


On Tue, 13 Oct 2026 09:07:15 +0300, Fil Dunsky wrote:
> Add a binding for the I2C ("Bi-Wire") controller of the Cortina Systems
> CS75xx SoCs.
> 
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
> ---
>  .../bindings/i2c/cortina,cs7542-i2c.yaml           | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

