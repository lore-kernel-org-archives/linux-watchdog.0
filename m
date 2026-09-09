Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583C5803A2
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962951; cv=none; b=i2AJzWq6MEYFG4wJqAxinUW5HXfUUVspwero1SiqPDOSAu+yrZmws7Vv9GPG+GFDxqZJzQW+8+QHXtRq9biqEClKdqdOic5+iDel3pKzmdba5yTEwiUN9ayQWSDc9PtK7ExQknCZCrGeW6tjt0eFJOIFy9n5nE8uvLm7TWBoBPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962951; c=relaxed/simple;
	bh=KLWVqQguonffGnm851cAXBHrTBi1vUkJhAMAInMTy3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+wwSXleZTgr8jO4GInC0/GugVw6upHDh++5eevChSnUTWtGS3F8eJLdWFvy2sMgyYTB90WtF0nPf9brHPs7xu8+tHL1b0Gh+BY0KsneuT0eR+DlzHfWWc9mmTudn5bunduhZbRXjJsu15idlXoJ752l7jo3h/+8GfH+SLbpRq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dk6mqAKR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk6mqAKR"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso4501706a91.1
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788962949; x=1789567749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYNhQ6Yi/iRYbkVUGBJRb8uet/bvchjSmRRTPBWP7EA=;
        b=dk6mqAKR/Wx4GWI6Qw9PFQEqDmH+DrfJDKmA63sKeAe8lvh2XFyErth8/p+hRo+k14
         KS6JrlMjjyy/2P3gxBflsdkpjoaOdhqo+2PJy9wZbsE7ZctgDjhKqaoSE3Z5BCZ9J3K6
         B0mwrMxL0WG9g0aOvU7PxFFgnXFFAPmdk2VeGoxVakHVJ2oXDs5PxOoMbq7lAnwBsdTW
         InsXSjYomk+r7zEFS0dsJK4RxMBWmr9jqjgQcKcMjEz+9q5aaRgzgjoOo1vmGAH26agN
         AeiktqdnammJxbsO/YWfF4MDWUgilGGyityuSiBMBY0/4vvRs2rnyAQ6aRLQpD7UUzSA
         j97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788962949; x=1789567749;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QYNhQ6Yi/iRYbkVUGBJRb8uet/bvchjSmRRTPBWP7EA=;
        b=EDafyiVx827YuuNNygTsc1DliHe19Dsph2WeJ70BJRK/R+FMzvTMeXi4XVxenhDujU
         ee5Az4rbhaLdY/xhZYJUA19eFMGt+fkUyzv6YBBTO6cjgeVpPqSdIPh9oucp3uo1B7l3
         +N3LNV3Nkj2DNn6WHOYsYTUZ69U59QKm6VNCyGWWy3uZjwvgeRkxu/qL4GnYH2yCF6mw
         i+l7R586KkNQZhvH2itev6hkg1RKllDumySzQwh/ZqT/tXWF9GEF/PwG51H8c6K6lXKa
         cyYpTZyScmtDnElotTJ+VnhtRbc7Is7lkBUsZ3tcEwx/zn39tMKCMnds/cJpf2Yli+BQ
         KVBA==
X-Forwarded-Encrypted: i=1; AKwUvBxtXKcxOJAeMIkGg843w7yeaM7yPIo6Mq/C4Iw/hJ8hmsEYVcz0YB2ZKARPG/ZMmw22BJ6j/ASuk0z5mkInsg==@vger.kernel.org
X-Gm-Message-State: AFuF++lahyTy08fsJDTA6/ywj5iKpAYEbbfiBcIxn8cbQU+Hxr2Zoh2s
	2mRlUDHmS2Q89N3x4ZEtofa30BTjIx1Jd1Gq87YFZ20NBEygUOFVUvh8
X-Gm-Gg: AYBFou07YLhhWzO/F0Wi4DveXD+PxYH0PT/COvjpCy8kEIceIMjdz8d8p4M5mV4prmU
	/Sk5SoWn/QhAIWWJ4cWtgHCs8GArYexSkvRWvcZljtVD3PZOj8JToT2xH55rhOJq7twVY/Bwb7m
	H10bVFpTq7HszRJEinPv2HJ3BmiEwIEWFNPv+nnMO9td7CjNw2xU49WMpWsc8ovkXSL2bAwlv+b
	dJmaZqeJsF4w/gmjr2421CIf/8VeVPK4D5Rgt08SuWMhP9OvBNqXwTqVffFuxYP/QmCc9pWPwsn
	aOi8MHi8GuBitCJSOCJdp8xXfRQd9nAzQ/0Me0UFkgemkzen9cZi/MsBu3AelEqnWNKoewEY58t
	dGr3BLjwhmFpH1MKlr+T+cpYVkuCYX/KKL1We+kiA6u8fLKGUw/R4FrTgCmWrsQh5j2GsZ13l9f
	QNQDfBCwCb39uDPPz3boPxmaEwxhc2BFThbYCe0RSCBPBhxhLtbVigp74c8qG1dZdXWF8Clj3kx
	BeVe+DvsJnc3BgcoI/uPo3Ubx8Hf4rUVwuiPCTZyxxat+S8
X-Received: by 2002:a17:90b:2b8b:b0:398:c0ad:711c with SMTP id 98e67ed59e1d1-39b26272f0fmr55218364a91.15.1788962948995;
        Wed, 09 Sep 2026 07:09:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcd243sm39687906a91.5.2026.09.09.07.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 07:09:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f54c391e-5152-4c60-a52e-9c997c16f706@roeck-us.net>
Date: Wed, 9 Sep 2026 07:09:06 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] mfd: remove unused rdc321x southbridge support
To: Arnd Bergmann <arnd@kernel.org>, Lee Jones <lee@kernel.org>,
 mfd@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>,
 Support Opensource <support.opensource@diasemi.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, patches@opensource.cirrus.com,
 linux-watchdog@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-3-arnd@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260909132153.1596191-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 06:21, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The rdc321x was a 486-class SoC developed by RDC. While RDC's later
> products closely resemble the DM&P Vortex86 product line and are still
> sold under both names, I checked the datasheets for those and found that
> the GPIO and WDT blocks on them are incompatible with the rtc321x.
> 
> Remove this driver, as there is no way to run Linux any more on the
> older chips after i486 support has been removed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

