Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E5285CAD;
	Thu,  9 Jul 2026 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583293; cv=none; b=BrQyCo2C8H5uWdOWzih1YrbLqm9Hd1sNN/qsi17p7wY4LrwMz7pjsXICzjMJI37cAfa/M40iczCAwdKnUx12FDmr0Y92645GP5cl2uBhnysKiWYYySjGIrnVZGZviQxdJSR+3061lfQAjQ6Fw6xyEqlfIrMcdnZBI7OAsk1JXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583293; c=relaxed/simple;
	bh=4E2vZPlsb54o9U2CHRxIeYOMNh/VtlYJ2M8MhFtbTeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YPgoBDBMko/Ba3pGnOtasfDLQs0BNYaH71BTAVXjcbNrJGoBLsvFjj+NuXFAEwa4dLBX4F8Kssr1i3301Soq3CaQhByA+mhAPt8kXsFgFrI8EIt6IpI7TiSS0g8emrm8vwTrpHJRy2dD0k7KjuY/SsSrHOnhsGoPuT1IIbKNkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJH31OmY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJH31OmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8273E1F000E9;
	Thu,  9 Jul 2026 07:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783583291;
	bh=3O0a7udsjYZ6WWbRNIHV3MFl7vF3eePsGu+G9FZ4i+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZJH31OmYgVdpw3s7934HGDXZent6sF877aQcZDYjQKtDQ1c35CuDuTTh0KWYhrDKG
	 B8Chg6S5Gcz2WXAhcC3bk0JgdPi6arcSgk41jg+kUlWe9kBr1HHwaKQQe42PfKXhDI
	 epsK+YlVWFgkiN4wM0bUHLkn5d/iI+MPCjyNgQiWtIP9BYCwM0iWDx/C5OEeP4l/08
	 6mFsVyckxBhJylkEYffcoWLbpHMDvtWTeROAEUVA/Zq9c8be/59vxO+kqdVBU2KyuQ
	 PRoOuNJnnZbJwl9c3N1GMhtxG5HvWpZj92s4SJcg7oqzUC4+Mg4fHEV/BtKWNnpFSg
	 65oCXicrWiejA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and
 t6031 compatibles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-9-55b305833123@jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-9-55b305833123@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:48:11 +0000
Message-Id: <20260709074811.8273E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mismatch between commit message body and patch contents. The com=
mit message states it adds 'apple,t6030-pinctrl' and 'apple,t6031-pinctrl',=
 but the patch actually adds 'apple,t6030-fpwm' and 'apple,t6031-fpwm'.
--

--- Patch [9]: [PATCH 09/11] dt-bindings: pwm: apple,s5l-fpwm: Add t6030 an=
d t6031 compatibles ---
commit 311071f5987c86b8cc9cbb237a0d70bae746172d
Author: Janne Grunau <j@jannau.net>

dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and t6031 compatibles

This commit adds new per-SoC compatible strings for the PWM controllers
on Apple silicon M3 Pro, Max, and Ultra SoCs.

> The PWM controller on Apple silicon M3 Pro, Max and Ultra SoCs is
> compatible with the t8103 (M1) one. Add "apple,t6030-pinctrl" for M3 Pro
> and "apple,t6031-pinctrl" for M3 Max and Ultra as per-SoC compatibles.

[Severity: Medium]
Is there a typo in the commit message description? The text mentions adding
"-pinctrl" compatibles ("apple,t6030-pinctrl" and "apple,t6031-pinctrl"),
but the patch itself actually adds "-fpwm" compatibles, which seems to be
the intended change for this file.

> diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/=
Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> index 25ef04b60ca17..dd95037ea5eef 100644
> --- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> @@ -21,6 +21,8 @@ properties:
>            - apple,t8122-fpwm
>            - apple,t6000-fpwm
>            - apple,t6020-fpwm
> +          - apple,t6030-fpwm
> +          - apple,t6031-fpwm
>        - const: apple,s5l-fpwm

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-apple-t603=
x-initial-devices-v1-0-55b305833123@jannau.net?part=3D9
