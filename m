Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFDB3859EF
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019539; cv=none; b=TX9hkhRruTtLBf2bsqZ2jKIafgwwns1b8DdX1zTQCi/3hFdHhlIJuCvzKsGlAoimH3BaS7Pfdfae5XW2LBqfUz3Mn/PqNmx6m1RGO+60fLRC3n7fHvR7cSer74Ctcyndc7IkbRNgs0hNIje7BX1Cg8Ez6yuwU0VIJHOkU4sKh7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019539; c=relaxed/simple;
	bh=AVIYuPCgubCuYve1OA2lx01GpnFJKVLmIPNWXCKWycQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3x89jnmjuz1kMrl5HPlYi+JhrhF9Bq/UpvIWhaYL2FU00h02vwePPMPzuQIU47yK7+amO5rJWcqPYfyWMCha26K1Hbyysf11/LQj9HFoUJo0T2JOmFhxmj+6wQQTiMWgCAEYc7NWfsar2LqlJ/vrHN3BHoYP2PCuzr8LPBuCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQgTSdZ1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQgTSdZ1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493be1b9564so16198365e9.2
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783019535; x=1783624335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yWVl92ySB0LOea/djTBKxUFhK5i6uFHRlukNHQHiJp8=;
        b=CQgTSdZ1EJ9vC0pV0hRyu8KzEoFEX7w0dfkqChjBf7ehwthEQjfQlUeUkOaPX5Av3o
         +VBg78ISUalx/kXmyqhgb0kCHoEpJWl2R0FZToH75WygA/M6dYT1h1S5fyXLtvwnEN57
         QKHrfXLl69IVqofabhHiK5hBN6m4NYe08jkGfdp0hE1FQ5Y/qrFcnLmWy2fOog5nuH94
         NMW+rvrjkAhFamtDmqf5Dl92yWE9D3YdpYNtrno6SefvbBMzQMGf0b9H5fIfsAf6qmw1
         d5nmkSpsbhRfTB/RDAXYY60F8LUWKHIvG7mzVwahroQEEmRtX17iXTVt8IijMi92pi1t
         rnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783019535; x=1783624335;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yWVl92ySB0LOea/djTBKxUFhK5i6uFHRlukNHQHiJp8=;
        b=lst5Y67qXdzshdG4Vbk07ONFzF5EDl8lIEoRg0nAkXknrduAFC90OqCrKiWDCx0WLS
         eTdUpYY4w2nBtFW3xTXrpkwy4d5DHlRE1iSo3pAR4vETauABi3cS8fXDcLOWD0z5+36K
         FbSTQlmn13YaHOT1os00n2NOShgg8pv4G3BmJXjqPXse1D/NZRDPuEQAnSXHosVYuIsA
         XyOH20NsvDm4G0pbiHaYQ9WRli/X6sIEIViTGHgooGvOVWSfUg6cA9+sIy02x6/mbV2d
         d+1HPPoUJcVdxJQ+YBrKbj0LnZZNew5lb0/AgNMnQUesPh9HrpZxZQyvoNgN1aNxn3mb
         8uJA==
X-Forwarded-Encrypted: i=1; AFNElJ9AWVV/EPBoEesp9Il2U10sLMHwyUZK9DQcSoxJ1fJxLHAA2VTyya5iO9qXU1vEL5wBSzDWNdxFK8+3j7m8DA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7jfsYD03apwoicH0vhj/ckAfkk/jR731gFde/oWDz6HZmO1T
	Zg+BvMpcPevoVnUGWtf1GxAa6mWEGOQA4J87xAoVXxpS+tSIB1Yoq1WS
X-Gm-Gg: AfdE7cmQSZlSPxYLGW7Vnm8HTQ45cXtOskRiHxcpCWqbCSVsdyP34jWvVQ2b9LbkWi3
	h3hQIYGjWBDy9IAyRYzsiTG/pxWLAdPC238mmseAtMhwVQtSjfUiAzJHWQz1rFHFbmUxHe3WYpZ
	ptrGhE7raF4GP/kBIKTuEDqIKy0WjeHI6sLEqceg/MqRqbvTvVmnSYtOIy8pxiLgxj0+tk81YUM
	Ty8ABz/UvNlSXJwIXNjvp9ER3oZo3IvAH9WAvlJZV2HznwrGAW0jjDQFtkHYVlbCght4QnhjUFc
	Na/5RGFkTei0NoNtSC4FvV7OqWQ8GgPijxB1M8quppxhJHM51MGv0DIo+Jgq8xO+3Z1Rkny8HYA
	D7VpK7iYhwVjcgCSjrNl/pligmSpv5OIWFCSO/lho+Co4rg/m+y6/cX/YH4YZ7N4aM8F+yVsnU8
	3d3pkjfOn5O0kZEC3jRMdD+c9N6Mm/jV+t0Lh0huG0mIxvUNT9qpL3+pbeCBvdbWhp7OWd5r6qy
	LEnKLvl
X-Received: by 2002:a05:600c:290:b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-493c3cd5967mr65147035e9.8.1783019535315;
        Thu, 02 Jul 2026 12:12:15 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c636cc08sm83399065e9.11.2026.07.02.12.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 12:12:13 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <eff80e31-f833-4790-8114-1ece4ed3a044@gmail.com>
Date: Thu, 2 Jul 2026 20:12:12 +0100
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] mfd: aaeon: Add SRG-IMX8P MCU driver
To: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?= <jeremie.dautheribes@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <20260630-dev-b4-aaeon-mcu-driver-v6-0-d66b5fcbd2f0@bootlin.com>
 <20260630-dev-b4-aaeon-mcu-driver-v6-3-d66b5fcbd2f0@bootlin.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260630-dev-b4-aaeon-mcu-driver-v6-3-d66b5fcbd2f0@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas,

On 6/30/26 13:51, Thomas Perrot (Schneider Electric) wrote:
> +config MFD_AAEON_MCU
> +	tristate "Aaeon SRG-IMX8P MCU Driver"
> +	depends on I2C
> +	select MFD_CORE
> +    select REGMAP
> +	help

Your REGMAP select here strangely indents with spaces, while the rest
of your kconfig attributes (and this file) are using a tab.

- Julian Braha
