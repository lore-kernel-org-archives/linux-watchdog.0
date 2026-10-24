Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812082;
	b=0pOAqGBeEL+u0Gkwys+2hSdOQka7wIslHDHm39BhW0h6lMaizxV2pyEH+ip/giA2VD+2
	 5Zu+9fV3PK62seh9ftssVit/zbqsX2/563RMrD0bqjeomX63sIFa5putE64299U51KpzI
	 pJ9X0oOb2v2R0ISp+zfLL66ejs2rtAeHsWSi/IK3uyODq3JVMZw1lIAZF1tL0Yj5nCGuR
	 lSUe1gekAwY6ey0SvnGhnjlIDL88fCl2MELsCwF4GZSsXc7ypKoJVfjIv97J/hOZwW+qL
	 Hj69Oe2jIbzL80KQKv6u33WvBtKYlu82uRryXR50meQehpocUY1dsp7AF2Rr+VeC1sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jS7Czz+wiu7WFrzrtvYg+PFvQraU5/rTwcpARPMwsP4=;
	b=rBsmzFLil9po7oUuZfCMxXFq7jsZlLCmgR1lLw74X2syrqct2wn3Ysd5DohZf26cZU/A
	 2eneN6J4Ve//UoJKhgCYgQOLRbOI6+ztqDdGe0aoYj1XZ3FupQtpS07fWXFNQTEAa6AkY
	 tGUceGYGAkeqLN9TdK2W7iKwdhwDA/7HJ3QuKg7mVS3RoIAcjNnevpjX2FKdvEFxjTyUx
	 FFjSkgCNJG+CIazWH4xTFtl2ejK7dRm7x/3sPZpfl+mDWg6TjN/N6KlNcBCdM4tan+89w
	 +022uQtjr6ltl2UjFcUxSErIUhyqhlg19KlOTBbrzXgwfDb2eIFi3s8iVIXZqR6n25A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QFYU8gQh;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287CE606A31E
	for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 03:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 287CE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QFYU8gQh
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2569866eec.1
        for <linux-watchdog@vger.kernel.org>; Fri, 23 Oct 2026 20:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812081; x=1793416881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jS7Czz+wiu7WFrzrtvYg+PFvQraU5/rTwcpARPMwsP4=;
        b=QFYU8gQh0JIU/1g52xf3dEHUMnFoatncMZt//oVQLvOUORQ3+YpGk6I+NlObMEnGtG
         0wUOG9usTSJR4MqdM4LoI6Qyit2Ydh6/vnmXXKXp6TMfZlQC48aNe2TyGiEgFho1Q6dm
         lhd8pjeM9yZ0lxMZQzazMovsYJDTmyJTatJ9/g2sy/E45676EIAnohGaMbXW3ypR1qkL
         8ucgiCaXni/7EuO7B/iNmMvwElKPWr17+bCCiCYNVPeFou1cs3+oC2u4G7r2HcMXuk5p
         8l0cqwM50t+/tUVPbSa+fBP84Baa84M2VB0ehYRcarH6ZtFaTPT4DMWAwA3d39r56OqJ
         ATkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812081; x=1793416881;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jS7Czz+wiu7WFrzrtvYg+PFvQraU5/rTwcpARPMwsP4=;
        b=a/GWhVFaw6iUQDlrV+TzZowtsxItV+s76a6qKy4nbGStTGeCPxPzQvdnbgqOy5KnaU
         MaJBh4xJ/5bD6ZDKDxmJwe1WE8h//ktrCnr2p2qD1gffMracahIBrBrmPVcsiQutUxoK
         Up7F3Mk/CmyVRU9WdZfW2F5/50ZAVZXBi9MjKS5FO0MFfSxQaU9g3gWZ2/MJE+3tmffi
         spQKzw+QefDaYaPsd1lC0a3s0CKa67huedyxw3PS9eIt5rkeiKLsh2uos4CYUQ8PBBZx
         O7+Vou8ECZk9n9Sf6SLHjVxszbB5gcrm6UOeAnznUKig4/067J9F9zvs/RGvKpNSQXVG
         cBMg==
X-Forwarded-Encrypted: i=1; AKwUvBzEY/18MriY7obVEJw5X8HIP39petV5nKJMyYXF9eJJrL3NZxRVwOfUZLudpwUP6quwLfoKYABjbgXR/vV42w==@vger.kernel.org
X-Gm-Message-State: AFq9FYLmtV++z2n7IxANzZ2S3KjRJHezpHY9IH2XBvAQmOg6Tu0fVk7k
	aeziz9LUZ2jg/z7oBOIYHstwwKKhrcpSZiYoBPj5L4msi87t3ETLj1+w
X-Gm-Gg: AYBFou2RNFf2SE06ilFhVXb6Ju4dUH0BS5iShk7LzGK6NULNpmPPSe9a2GRo3QSvqyl
	sEAmTR7eugZaGR+gXHSHvTirVNKzWyqHR1S9ebuKbUmMrnyiKSWVdPX411bIDncD/c/SDx54G5K
	M25aWhHTwv2vJfxpAJhNkS20YXmtke+nMEVK6RYypjG/MC5o9zIto4bjlQp5YTc1Csj0kjR1qtM
	aX7cb+3qBM9F8g2JY0C0UpZvhFOcDXa8+/iu+Cbx2UfC7H+eL/MEtvzCXrq/mzotpzn/GmLpDvY
	iCWie1Y/UakK6YgMCQxVKWIVVMbj9mAA6y1eniyBFBF19KQKSN66ndEP1lIJ56bTkLV/SrtTI2E
	Tujk/bCXCy6sZJon0ovdG5yXnMEA/mrT5h8If8Bcg843PZVSeZQpfStXcOKkHXj8LpUWGR4H85X
	XPbKY+0dbY8QMgWQpGUsFdAIx7d6AW5B97KBmIUusETBJ6QwNYEzWe2GM9xVReyN5zpj0RNPK2E
	b9ZJsF3sRNcxnrQEaw4OTV74oynaGmehkMr6GzX3BsYvcKKN8r8qoc2PkS8J0boCcxH4OvrYiA4
	MO2T5t9rXbcf48MndkovhidTxBma+nSl
X-Received: by 2002:a05:701b:42cc:10b0:14d:3c0c:79e9 with SMTP id a92af1059eb24-1993505dfd6mr1266066c88.11.1792812081124;
        Fri, 23 Oct 2026 20:21:21 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:1f81:ed84:76da:ac36:f699? ([2600:8802:b00:1f81:ed84:76da:ac36:f699])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm3107744c88.11.2026.10.23.20.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 20:21:20 -0700 (PDT)
Message-ID: <fc0dd1a5-70ed-4c4d-84e0-94080dd5cc38@gmail.com>
Date: Fri, 23 Oct 2026 20:21:19 -0700
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] MTX-1 watchdog driver removal
To: Guenter Roeck <linux@roeck-us.net>, linux-mips@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Robert Marko <robert.marko@sartura.hr>,
 "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 manuel.lauss@gmail.com
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
 <85d47f47-1432-48fe-b83b-4d53381c5461@roeck-us.net>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <85d47f47-1432-48fe-b83b-4d53381c5461@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/19/2026 6:00 PM, Guenter Roeck wrote:
> On 10/16/26 15:16, Florian Fainelli wrote:
>> This patch series removes the bespoke mtx-1_wdt driver and migrates it
>> to the generic gpio_wdt driver which it should have done ever since
>> gpio_wdt existed.
>>
>> Assuming the patches are satisfactory, I suppose it would be easier to
>> merge those via the watchdog tree than the MIPS tree?
>>
>  From my perspective, patches are ok, and I'd be happy to apply
> them through the watchdog tree. However, I would need an Ack
> from a MIPS maintainer to do that.

Thanks! Thomas gave you his Acked-by on patch 4.
-- 
Florian

