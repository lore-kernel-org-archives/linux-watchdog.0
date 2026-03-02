Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192362AD03
	for <linux-watchdog@vger.kernel.org>; Mon,  2 Mar 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463889; cv=none; b=ORX8akKN2rCmHunfc5/mZLtQQhOi31O8rvhvSEPAFOglctuYjLon4WtCDFerBbEultTG7oe6Um5WQffCss3Om1HrNlfd/9Y6rqJmQ1lnvKohpvJ9txkgujNcX9Qq3JN3x0JYsUFzQKWJ1bept5JQ9jvDe54w3GodKNk0l7VYYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463889; c=relaxed/simple;
	bh=Z3QuW44a1cqmJAISoawP8xM8uOw+Gue0DhunUahM9Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKccWpKsvFpuFthJkZo05lckZWVIQ1dFIF597Gnmd9r+oRCRhgdLSizIEOJ+Z/8ZQa9hNyFp9QKBZwUAFKuoc23Os7+6ES5dr7X40LKa/n6A5jT7O2CULlH0B9Zglqu6LNeBOK/96csPjp/8e/mlGYBM8/Z8p0G6HS4CP0fsk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WruRTr3d; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WruRTr3d"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2be06c02f66so2976475eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 02 Mar 2026 07:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772463887; x=1773068687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJQJNNM+4DO9CQxRQrJTKsiJbgSUIZ685yVxcgsm7ic=;
        b=WruRTr3d7U8Z2pIdAmkls+egdPYBPfFo5wW3NFFWeXLLB0Im7vVRDV2PrNuz/yhSDR
         gKnnwBCz5L2+ssq4RtN7eGYiar4EGGRUt9E53m/NBS7Nlxfs6VI7Lh96+7vbTiEqoqJa
         TVFQjVM+SQAvjg4Ch01zaCmsaYptDT+dwtberO2qqmx5tReiPHRSnRfBzfCMccQ0Jqix
         +ofOK2wGc+yCydQycFKQUAK/xrxibd1Mp4ZA24mVUaV7+eUC6JgZzXOTJKLNCbClgK/W
         vC7YJna+FfI39W3pq+j+wDP1REc9Dkuv970+3OTsu8zYjLYcmoYX1aFWQ/h4f2sqhvzI
         939Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772463887; x=1773068687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PJQJNNM+4DO9CQxRQrJTKsiJbgSUIZ685yVxcgsm7ic=;
        b=HnwpG5AF3ty1/mL00xpDvGmAA1NXCHErQrx8pMeI1jT/99Z6ys/jWQrcMV59bmI/xt
         A+GnAunEriPeDY4Y1KYZ7CtpJrxKQfHT5MfvgjU8K1gPA+kUItmXIoFI06k0hU281v4u
         jcyM/KITep7h/fHVDFSfL+9PdzvQy2kOLbBR6akhendQyGolPWXsv0Kw/Ez3PDV4ZmT/
         0TexfDmrWSMg7wpQV6H8P9owJDtigRfLTp/VhZtc3vUDHXx3u8YyYxEIKxwREWyd2J+C
         VmZJKwNwj9SGiFMS57e2w6Uz+Chl5B8lReXOw66a9Sb1w/vyIlF6MTm1J0eoRhp1TQwM
         qkgg==
X-Forwarded-Encrypted: i=1; AJvYcCWaLy3I6OIKKIC1jcxsS3rSrAdWOJ30p5nO0t5V3QZeZrVrcN+0lTnGfyuQj4maAPUjyEL4K/gvdk+50krgiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJIm7Hi3jXcvNutpKiSVpZWbTdUVm3fOj+jAS6Sef30waCWsM
	MjcsrQZpK+HLdh6gft8Bjfsm55bAEt0XVOjwD5mVNX0GX4Yht8vYd15N
X-Gm-Gg: ATEYQzxZk/nt8eNMwSQj4xms6Wg7SA13rQEaxf1ZL1KOblWzzI0zHW66CSUfz9RJlc4
	gM7hqlwHrTGzfcljSiK0x2a6AEGHnSbvBKkimdH4KovXpFB+QncPNgKt+Lv5QU+OAX8FC99OHHE
	50jVfqmIvhKWxDU4BlfMSar+Nj6h1zPRNYmLXgfznhDgakH2L4x8DQRijRd45uUjh05nkYp6kXw
	zkLgMe1JojBfFdc06SrGj9cDT72W3JGSJmQbbi3TdJp977spZqYeXDRKi2XJOkcpjvSue95NNKv
	0v+ZEplk+dctpThOl+ya4X59goW3QQ3dgEgo9DTTeNFmnrdt02h1GNS9c9xTEJQeFYw+lNyA0Hz
	gf/EMMnET0h8mhmmW58BeRczFh3ELyaQSu5AC9aZBUCZpZi6ZdRVH0dztKzJwsuVCYjan3RYnTC
	US/+p4ci0FBA6Jdz+EXqPxwtYSywT425rgmday
X-Received: by 2002:a05:7300:f194:b0:2be:142f:d48a with SMTP id 5a478bee46e88-2be142fd895mr1194048eec.27.1772463886899;
        Mon, 02 Mar 2026 07:04:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c01sm10987949eec.16.2026.03.02.07.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:04:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Mar 2026 07:04:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Walle <mwalle@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 7/7] dt-bindings: hwmon: sl28cpld: Drop sa67mcu
 compatible
Message-ID: <917915df-3a4a-4cc0-b41f-106b5933db20@roeck-us.net>
References: <20260302122540.1377444-1-mwalle@kernel.org>
 <20260302122540.1377444-8-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302122540.1377444-8-mwalle@kernel.org>

On Mon, Mar 02, 2026 at 01:24:52PM +0100, Michael Walle wrote:
> I was just informed that this product is discontinued (without being
> ever released to the market). Pull the plug and let's not waste any more
> maintainers time and revert commit 0f6eae86e626 ("dt-bindings: hwmon:
> sl28cpld: add sa67mcu compatible").
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Applied.

Guenter
