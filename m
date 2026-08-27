Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAE43CE45;
	Thu, 27 Aug 2026 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823957; cv=none; b=T+sHaIWQZgpXPJphl1pYWI+hOabljoVf2/9v44GhZHiReYMByearrrtigvYUo+hZa8GYPE85NO42LiA2I6u+euibMvv5mI7KIQhxu+TcygkJggW3cZG3DWOhWgfAXqdPF354I2ZqqBoMUMLMI3Xx3uNmvAhPFcGeUT2XGzhJF74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823957; c=relaxed/simple;
	bh=+jTm3OKJ0tz0Ytt60lrG9vDPD8rlbV/F8CWtpIzZa7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkKZ8S/s8+rpgwJQhgIDF9hxHu2R+t1wCQB1S4khJi/iMmQpDLu3j7bnSd3iGaBVYGwMAjm7ukBOIC/eRZusvuPaVyJUVq4o0w+DEJSVD8KrB+H0uTMq6v3v1eqFLR5qlPnS8cRJV4UOhvRXL2nYdNR/8e08+UO4Rvs/+zZk9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvTlC2Op; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvTlC2Op"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A004A1F00A3F;
	Thu, 27 Aug 2026 09:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787823955;
	bh=kVSoIlcrtimXOF4wgHNdqqDm7b4TiCLUottbj+bvSMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KvTlC2Opb/LACvVIEtcVukSOcNkF5fgddnik77sTC1P/A7MGls0ANUE0zgHW6Wdpc
	 LI82HoNNZdqJ3hJyvHSVcyScMhTe1VLTUdi+6nd1cDSdJPMZigWsTGvHvyPs/28CUB
	 58s0FVNh7X0ykZ9Kgs6ORKrxGku087Q6cpSf1Y0Blg/RUY09SiT+GCyP+1kFz/JOKM
	 IWkaCTk6EbSns/GmAJFYAHS2f3UgamJ6y3bjs0Ph8FkI34U3LyykuNss1NV9IfgIV3
	 REhfB98M8F0+Yz/ztb5KFm/eNhiMCYi5mQ4p8qpc4eH8kvo2o11e1YsVUNAxXkjEkp
	 1eCsJfBTgteNQ==
Date: Thu, 27 Aug 2026 11:45:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, =?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>, 
	Guenter Roeck <groeck@chromium.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	avaneesh.dwivedi@oss.qualcomm.com, Umang Chheda <umang.chheda@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: reset: add PSCRR NVMEM
 recorder binding
Message-ID: <20260827-spiffy-effective-hare-c05f53@quoll>
References: <20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com>
 <20260819-pscrr-provider-v2-1-9072383e0f4d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260819-pscrr-provider-v2-1-9072383e0f4d@oss.qualcomm.com>

On Wed, Aug 19, 2026 at 10:50:43PM +0530, Faruque Ansari wrote:
> Add binding for the PSCRR NVMEM recorder. Records the power state
> change reason into a small NVMEM cell, such as a PMIC SDAM byte or
> RTC scratch register =E2=80=94 so the cause survives a power cycle and ca=
n be
> read back on the next boot.

A nit, subject: drop second/last, redundant "binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/b=
indings/submitting-patches.rst#L23

>=20
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---
>  .../bindings/power/reset/pscrr-nvmem.yaml          | 59 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 60 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.ya=
ml b/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
> new file mode 100644
> index 000000000000..5334c923d644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/pscrr-nvmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVMEM Power State Change Reason recorder
> +
> +maintainers:
> +  - Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> +  - Oleksij Rempel <o.rempel@pengutronix.de>
> +
> +description:
> +  An NVMEM-backed recorder for Power State Change Reasons (PSCRR). Persi=
sts
> +  the reboot or shutdown cause into a small NVMEM cell, such as an RTC
> +  scratch register, a PMIC SDAM (Scratch Data Access Memory) byte, or an
> +  EEPROM =E2=80=94 so the reason survives a power cycle and can be read =
back on the
> +  next boot. The cell is referenced via the standard nvmem-cells consumer
> +  binding.

I do not see how this should be a separate device. This should be rather pa=
rt
of PSCRR, reboot handler or just the nvmem. Otherwise it is just device
node for instantiating driver.

Best regards,
Krzysztof

