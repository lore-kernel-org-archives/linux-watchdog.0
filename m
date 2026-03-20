Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7031643B
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023990; cv=none; b=mlCt3GqAM4+h+CaiDzuabKGbo7z5W15ji5dCAUO6pZoXsGqfUvsh+RYuJLixXEpwFEqinOYjvCLQbtLM0P/xXMnVkWqiwZJxKeA3YFdbvhfy5AupgCVd80uu6Lt2uGeCkHy9/4KO6haw2NUVtnLO5+BhHdodDsD+9G0kTQq8ZGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023990; c=relaxed/simple;
	bh=fMyFSszCJXOXIv+DX7+R6wPDH9WSrMIYlywm/2fLRog=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mOn8IyJ2b73V+pFOKm/FC81AR14LvWA/W7IJzLV5rtfAU98q8IK4vsdJXd2bBmr8hf1+BGTIPBgnSy37FOyeBx3a7lKD3+VNj110rE9SBLZ2tbLi/28JPbTZlLoO6j/CrGg4FFQtirpESbBYqaPGLsbPJ7APVFOx+HlNDpwWhg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=f0nKMIYD; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="f0nKMIYD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Subject: Cc: To: From: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1774023982;
 bh=ft21UeP4z579XSbja1g9AqWPvCF44UV/oZHoOxBnDIs=;
 b=f0nKMIYDRphYCijUdznF3+0Jiv0q/sG8581AIXOISR2BKIYNpQ1OL8gRvyHm1w8hfFHCJAp1d
 06OEbO5j4VMmsj2HJyQ3PvWnjwKlgsAIBZcZTQpl/Dk6J/8yZUrEdi2u22Yv5/9F6fffXlhUdrF
 M/+yDmgshYAKGlLrYrIeHBtjrSMKnHATX2/+GFjAiGDKEaqaBcQNXPd7/dgjugkxHu4WNO0UQsv
 nu0jr8AgFb5JwIKSe31cOEC8+uAWfn6AQTtqoJo/nZNbevE6QNM0D9CLnXUVL1FcldyYj6knJpn
 EI8OzlK0NcXZ4Saom0ylCOZoLVkqDbIJZeks85gJTIiw==
X-Forward-Email-ID: 69bd60d63c81f5afefaa2dca
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.53
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Fri, 20 Mar 2026 10:59:32 -0400
Message-Id: <DH7P658BN6Y6.2NN4PAO1KAEEQ@ubuntu.com>
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Janne Grunau" <j@jannau.net>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, "Sven
 Peter" <sven@kernel.org>, "Neal Gompa" <neal@gompa.dev>, "Wim Van Sebroeck"
 <wim@linux-watchdog.org>, "Guenter Roeck" <linux@roeck-us.net>, "Linus
 Walleij" <linusw@kernel.org>, "Mark Kettenis" <kettenis@openbsd.org>, "Andi
 Shyti" <andi.shyti@kernel.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Sasha Finkelstein" <fnkl.kernel@gmail.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-watchdog@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <linux-pwm@vger.kernel.org>, "Michael Reeves"
 <michael.reeves077@gmail.com>
Subject: Re: [PATCH 0/9] Initial Apple silicon M3 device trees and
 dt-bindings
X-Mailer: aerc 0.20.0
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>

On Fri Mar 20, 2026 at 8:23 AM EDT, Janne Grunau wrote:
> Hej,
>
> This series adds initial device trees for M3 Apple silicon devices. The
> device trees contain only a minimal set of hardware not going much
> beyond the minimum required for booting kernel and initramfs and
> verify via serial console that the hardware and drivers work.
> The hardware with the exception of the interrupt controller is
> compatible with the M1 and M2 SoCs and the existing drivers.
> Changes for the interrupt controller were sent separately in [1] and are
> picked up and in linux-next. The device trees pass make dtbs_check with
> the apple,aic2 dt-bindings change from that series.
>
> Link: https://lore.kernel.org/asahi/20260223-irq-apple-aic3-v3-0-2b732807=
6b8d@jannau.net/ [1]
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (9):
>       dt-bindings: arm: cpus: Add Apple M3 CPU core compatibles
>       dt-bindings: arm: apple: apple,pmgr: Add t8122 compatible
>       dt-bindings: power: apple,pmgr-pwrstate: Add t8122 compatible
>       dt-bindings: watchdog: apple,wdt: Add t8122 compatible
>       dt-bindings: pinctrl: apple,pinctrl: Add t8122 compatible
>       dt-bindings: i2c: apple,i2c: Add t8122 compatible
>       dt-bindings: pwm: apple,s5l-fpwm: Add t8122 compatible
>       dt-bindings: arm: apple: Add M3 based devices
>       arm64: dts: apple: Initial t8122 (M3) device trees
>
>  Documentation/devicetree/bindings/arm/apple.yaml   |   18 +
>  .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    4 +-
>  Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
>  .../devicetree/bindings/i2c/apple,i2c.yaml         |    4 +-
>  .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    4 +-
>  .../bindings/power/apple,pmgr-pwrstate.yaml        |    4 +-
>  .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    1 +
>  .../devicetree/bindings/watchdog/apple,wdt.yaml    |    4 +-
>  arch/arm64/boot/dts/apple/Makefile                 |    5 +
>  arch/arm64/boot/dts/apple/t8122-j433.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8122-j434.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8122-j504.dts           |   37 +
>  arch/arm64/boot/dts/apple/t8122-j613.dts           |   35 +
>  arch/arm64/boot/dts/apple/t8122-j615.dts           |   35 +
>  arch/arm64/boot/dts/apple/t8122-jxxx.dtsi          |   48 +
>  arch/arm64/boot/dts/apple/t8122-pmgr.dtsi          | 1149 ++++++++++++++=
++++++
>  arch/arm64/boot/dts/apple/t8122-usbpd-i2c.dtsi     |   32 +
>  arch/arm64/boot/dts/apple/t8122.dtsi               |  444 ++++++++
>  18 files changed, 1859 insertions(+), 5 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260319-apple-m3-initial-devicetrees-5c546ad977a2
>
> Best regards,

Seems fine, well done!

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
