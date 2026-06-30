Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1D3E3140
	for <linux-watchdog@vger.kernel.org>; Tue, 30 Jun 2026 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805646; cv=none; b=aTya2BzuUg0sX1lgwCHwPIXpQI5DN9gWQ5OKiz5cvpLvQSacuDQ+B19uNPfna/pi2D0sqBNFxAoFNaUd+4+I/Bmzjva5Fc4VSHn/Wv46OQTP8c0VNubzNrn8xmyNWjrSdZ+XjphYEsQtqYNXAy6UVWREfLot9dgQz8j75E6tURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805646; c=relaxed/simple;
	bh=O8UtlWA2/ymbY3Pi5cr1VAwTiB4Ay3GNCozA5qseyXE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHdexgZl1954rDk1DGBwZlq++NtWkYcWFiPkyxJoUlo+tTzqNFg5RJrd6L2nvXd5ZXUfcCMi04xae4ZJVt7iGxLiuT1HoUr/9FsEH6s6pqN1hJcWZgkNpFIjQdi4IzlN9sqYILgBUBhXQEJaxuwyTJutwG1F9p8/DDPNoG+ee9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5JY/iSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5JY/iSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC051F00A3D
	for <linux-watchdog@vger.kernel.org>; Tue, 30 Jun 2026 07:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782805645;
	bh=D0vA91JCy6e3U4Zy4A7u6z+5xLKwz9OO6mJyFAEDjWo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=X5JY/iSBvE5bIvOcIm0YQO9+bwx9WFalRg8XAdM/Dy7q/Oxzbe5Lkdbglu5fv0OUK
	 fJYCmcrcJ4/g5E3FdwKdBPnaotBLNmXbb9CFrnUr/E7ro+IoDK0sXIOJqsF5jzvDxC
	 u+4wKW4E9nCYz3WkKxgbil4glsu3fn7RvqeVrNXIkyRolwRwMM1hkhdCyiD3jWHJYw
	 kwCPOdcOxX8X4XTiAtrhb54ePGhfALetVicbqlcx76vjApOHgz18CZe3D6FHPSjES6
	 9AjqebUwzzoVRWUFStflre7HZDVvMAmy1dTZPWhBVKqjyv1iE3P3xynnO7atbg0hPR
	 0bEvjEPk8WHxQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39b14a7e53aso14236481fa.2
        for <linux-watchdog@vger.kernel.org>; Tue, 30 Jun 2026 00:47:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqzXqHDHVWHc2fcf4iDX1nHgHi7c8nTEMp7GZazsu05h0CfVRxUlq4gHqKQEsO7aXzRey6Xro3kUABXaunobw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+E9PUpLZKO5xe3icXVBYYuIouhyW0xxwQzgadluwZ4J9Hkk+J
	SWG8ndaW0aJOvvuFPIp23WMOFc6PogIqWXSBDCgDJ837TvD7bTIdSe00z7gTrf78nt3hOH/vhn+
	GARXsrtAdbMJKffDglLmtwKUoB8l1t/9MfmD/Qw1dag==
X-Received: by 2002:a05:651c:50a:b0:39b:695:32a3 with SMTP id
 38308e7fff4ca-39b1ddd1aa2mr5206931fa.13.1782805643902; Tue, 30 Jun 2026
 00:47:23 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 00:47:22 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 00:47:22 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <31477953aace52bb6594461e82ddf99493af2329.camel@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-dev-b4-aaeon-mcu-driver-v5-0-ad98bd481668@bootlin.com>
							 <b4396f57-3501-4e89-9cf3-8dc5d7cad9b7@roeck-us.net> <31477953aace52bb6594461e82ddf99493af2329.camel@bootlin.com>
Date: Tue, 30 Jun 2026 00:47:22 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdJJnRTOSEecqpX-EddJRAzWc_1a-cg3wrW8m0jR2Fihw@mail.gmail.com>
X-Gm-Features: AVVi8CeaJi7AWd-H-Al7farjl69e4bGemX_zfvWwe4vajt3tOcP7qfQEh_ha7H0
Message-ID: <CAMRc=MdJJnRTOSEecqpX-EddJRAzWc_1a-cg3wrW8m0jR2Fihw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Add support for AAEON SRG-IMX8P MCU
To: Thomas Perrot <thomas.perrot@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Conor Dooley <conor.dooley@microchip.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	=?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?= <jeremie.dautheribes@bootlin.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 18:04:59 +0200, Thomas Perrot
<thomas.perrot@bootlin.com> said:
> Hello Guenter,
>
> On Sat, 2026-04-11 at 17:12 -0700, Guenter Roeck wrote:
>> snip
>>
>> Sashiko has some interesting feedback that might be worth looking
>> into.
>>
>> https://sashiko.dev/#/patchset/20260408-dev-b4-aaeon-mcu-driver-v5-0-ad98bd481668%40bootlin.com
>>
>
> Thanks for the pointer. I went through all findings and addressed the
>   valid ones in v6:
>

Did I miss anything? I don't see the v6 neither in my inbox nor on lore.

Bart
