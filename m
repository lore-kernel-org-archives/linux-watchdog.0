Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3815817BED0
	for <linux-watchdog@vger.kernel.org>; Sun, 12 Apr 2026 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775952781; cv=none; b=pEyFBZKGFW9yTaSDtUtEwSv8zgi1UZkcROq270capz88xS4oMcxrWUGrYE/qUcYBZ1aRJcPJiHfNIdCBx0MqTrZEm65oszVM5bDTE9rGUxD2U+Yz99R31dGH719GPlXsQ1cgUQj233Z/vpV4Lc+6JqehsnZgaOgbS0PQGdyw2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775952781; c=relaxed/simple;
	bh=BnkXiP1EGS3R5lvyEAaBJzPphOHVRXuUFlBdY0++zNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmaPHH8ywUFzGRqYEpy/99opkjvqZy/Y17EyKx7rRsU9BG/6dzzksZeBqbDnJfHiVCl6dduy6ETRygixmAAkxP+5+GRf+EFdpsSS8rzATFNh7GE2eWld4BBK/iS4AGfCHcmgsC4hN17zeeb270vnXsH6hLtlDpzaGTAnQW4WWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYxXOR4Q; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYxXOR4Q"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76af79f029so1209128a12.3
        for <linux-watchdog@vger.kernel.org>; Sat, 11 Apr 2026 17:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775952780; x=1776557580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vLfrZeVjnvmp+3QkfrvuhDHQSzKHvUWkEu3isF9b4sk=;
        b=QYxXOR4QE0aVxCSvWTsBEVWVQS6M/Cv10q0P+Ht41W/TQcFmhxUIStzWC/ePNmHtkn
         V6EDgzoDucSSetlar/9int7xUVqR5stO/A4CNp0M/fJ00uXNkLbfv8gY5k2djOywPXNC
         TpqtBXrGims9rmDFgu/JmMDnLQAPSgZTGA6NPrQtoENi8MDrJDJn9csjWltY1eEJ5rF6
         urgMn0pvSo5GZBrrrY4gur+x39j7x1Ne2diKWgYfHvApqoffbVXrtwK/389t19pbVGNk
         IapLWqi+CSUiVGuqAZyqWU33CH7m+oz2IOHPxneLqvkGq+Y+oA/1CwtwF4bwFrgruu5f
         zSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775952780; x=1776557580;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLfrZeVjnvmp+3QkfrvuhDHQSzKHvUWkEu3isF9b4sk=;
        b=F2TQFbWvdTVBfq9eU6ub2HWGM/WlR6ZyFsHIegF8pwjsbtLVWzGUpXvHnMLrXPsr3I
         BIoPNn3jZsk8fyAD15uSCcuFwNyjlYzKovqfz+xAQAupmDwusL8dviHWyCdw92XAmHCD
         8ErnOGncrMwa7+HsdgC4Gf58iIFR3NIBDxDlCN296vctmkWkcsdDmZa/bKp9QT+58mWx
         0swm4JJLwdiB8faMHrhuzKV9tc4P6arvFOY0I6Iym/cH+RAtkEK9d4qzr6ALyWejlwA1
         J48oSukhSczYMmhznDIinlSqt7LwmA2uwgLDN8FkhbRYlClUHNtocm9pOoZRm1pTKsa/
         Xtng==
X-Forwarded-Encrypted: i=1; AFNElJ8NSyMARFpEjnfvOKQZG6kWfZaxDJCWoRkKTrjGElnOGSvoRzEQtEUdp66lDklQKgbUoSNuPohUka03S6g42g==@vger.kernel.org
X-Gm-Message-State: AOJu0YypsJUYdlmhqMjtScUv9sJFRrjpx1hocT6aLn6jEdCVFhdJ5VjK
	aeWxzDo6SIvM1avd2294iVNi8vlHKzudyUDciDFy+yLpogiwY6aaBJhA
X-Gm-Gg: AeBDiesHgNNpTyeCDorqGfl+HCb2cSRzkNOfI/9f61vHRjZES2vh9z+7kFvvWtGd4jl
	fqwnieFzdJ15sNwjeFDAjd8fLyj8WWLY/wrykx84wFliDkRtTs7kAXRV55LN9JupiUp61K02w9M
	QeWOUF53qnMhi5Z6u68/zm1SnYE64WW0nOpsnm1CsfL8GJuJa+a3l1naq90toiWSJyjhwx6f5iX
	YeqISF+EQxJvagOmDB6CU5PKDob3D9YysaY7UZxJ5mjcCxBEnYJaW9oFCwVhYN6qk8+ZJc6NQ5d
	UrxrlS4JE1RaI1njzdE5gqtvzOsqH1FgnEIPQEaUoWpzNgruz72SvPbCRQV13Rmv+v2H0MZVHW9
	0GygyZxPyPARW4RBhXdKHC3LwWyGfZqm29e07MYxykWT/+710FyVNYEuJo9W+EIZRCC+vSFURbu
	zFulc8Cpb9wx18cVkVR2po8fAmv70ZnN9wHAts65v1xay2t3dnTpZDNS07g7yZmnvrTjvgI/xN
X-Received: by 2002:a17:902:fc87:b0:2b2:4611:5dca with SMTP id d9443c01a7336-2b2d5a15390mr88995925ad.24.1775952779631;
        Sat, 11 Apr 2026 17:12:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f48d6csm89227725ad.83.2026.04.11.17.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 17:12:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b4396f57-3501-4e89-9cf3-8dc5d7cad9b7@roeck-us.net>
Date: Sat, 11 Apr 2026 17:12:57 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Add support for AAEON SRG-IMX8P MCU
To: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?= <jeremie.dautheribes@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260408-dev-b4-aaeon-mcu-driver-v5-0-ad98bd481668@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260408-dev-b4-aaeon-mcu-driver-v5-0-ad98bd481668@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/26 10:21, Thomas Perrot (Schneider Electric) wrote:
> This patch series introduces support for the AAEON SRG-IMX8P embedded
> controller (MCU). The MCU is connected via I2C and provides GPIO and
> watchdog functionality for the SRG-IMX8P board.
> 
> The series includes:
> - Device tree binding for the MFD driver
> - MFD driver that serves as the core driver for the MCU
> - GPIO driver implementing the GPIO functionality
> - Watchdog driver for system monitoring
> - MAINTAINERS entry for the new drivers
> 
> The drivers follow the standard Linux kernel subsystem patterns, with
> the MFD driver registering the sub-devices (GPIO and watchdog) which
> are then handled by their respective subsystem drivers.
> 
> Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

Sashiko has some interesting feedback that might be worth looking into.

https://sashiko.dev/#/patchset/20260408-dev-b4-aaeon-mcu-driver-v5-0-ad98bd481668%40bootlin.com

Guenter

