Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784558B6BD;
	Thu, 15 Oct 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096148; cv=none; b=qhwQPJdhVGk/GaHQyr7X4jr+uIuJuZXceRTZINmtbnqD7Oviz734ScEx+35QSajIszHdz99jQP1nH/9Mzm0h4g4zlwyRgNVLEO2pQU9csJJOP/00eYf88UIDzTWUFh0UO1/CxHlaZPvVShboYa5jBGQvW3m0sFLvf+2Z22VK8r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096148; c=relaxed/simple;
	bh=nswoFv5D8iLedmj7e5kqJNEjc48KlQLo2XuodPmeaGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ25wPMG8vqAQ7kcDoMCfdiNmzJiuEKzjFqxhbAug6S0YMhLHSN4cVipvDB2S+RbTR9zhZR3ykPQqkP37H07AbGDHfRwIAi/pElIuB0PetkwB5ZZqIlTnm9hcyBiW8tgfiZyyNOJSIqC2JTlMQ+k1JP8t3so8JOFpnq9Ca570xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFrc85ch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFrc85ch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268A71F000C4;
	Thu, 15 Oct 2026 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792096147;
	bh=qEg8SNAdAmVhhOprukrbfpGBzD2vq402qoyCsgGvGtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fFrc85ch4oOXZx28Gohm1eykD+7nlTOIl0hB+tZf5YWMNqv9W6JoMa3LgdmkvDQ2+
	 mTyEWfeyQMZtRHwuo6VpBJZUA6ulxb+WqE+FFCeSArAsQWWAD/vQWU7dod0DQn/Jl1
	 nraUpFPUdCB6/mDjgFfQ5qXhLpq5HB7NPNeU+jeMioMkwnHarZjG3utNJpY4G1+CPG
	 8IKChr4KyVVWUjZO32L6IEzCw6np6DeEqVjKU7rs0N7FZbKbiWh6x4tUaqicKGVAZK
	 gV5L/hDUMn40YQKLD2Ednoxi08hijjWElZoIJfm2gkXBnNqMMDpv0CftvsOe7mYIeL
	 IU0aMT0hyQbMw==
Date: Thu, 15 Oct 2026 15:29:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linusw@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-i2c@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 01/11] dt-bindings: interrupt-controller: Add Cortina
 Systems CS7542 peripheral interrupt controller
Message-ID: <179209614483.3070284.7098869162392776844.robh@kernel.org>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <20261013-b4-cs75xx-s2-v3-1-181bb0d23f4c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-b4-cs75xx-s2-v3-1-181bb0d23f4c@gmail.com>


On Tue, 13 Oct 2026 09:07:11 +0300, Fil Dunsky wrote:
> The low speed peripherals of the Cortina Systems CS75xx SoCs share one
> GIC interrupt. A small controller in the peripheral register block
> reports which of its 15 sources are asserted and allows masking them.
> 
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
> ---
>  .../interrupt-controller/cortina,cs7542-intc.yaml  | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

