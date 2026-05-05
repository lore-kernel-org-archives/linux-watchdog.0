Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDEB15E5DC
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986794; cv=none; b=VJ/KxXvMT7QEWwpoq35uTXSsTs8p4ynwyUcO/7h6mSZyYiVeG7AfONY4LsfLmgqx+b6n5SowOMzIWeeFcE1rJxuw/iutxWGfw8tB0ch2oVq0hSdIAl+epG37Jnia16cpGUGw+E6nwFU3B2GpF1kcU6awerwm2t/6Sjufsa0bMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986794; c=relaxed/simple;
	bh=cPpKhsX2UMrPQeRlYuGPuiw7pA6uSGlu1ci+oZalnEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceniTCHR1Buh9r41cXhzBMqh/K1umQewdsQO3RWfSWmEszw5GmKBkILatfxhSX49IVXmreccHAyogEWsrUBjAktRtzrcKvbINJXEHyy4ec/KWt6rN8zanL7lBBcxrnPAG2oX23esUrq2VkEZJ+enLswDEBzSdpK7nUdHQcUGJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQPLcvWT; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQPLcvWT"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f0ad52830cso3873021eec.1
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777986793; x=1778591593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbKzX+LHwufFR/q2Jodm0JTpS+wKmq0Ba1unQGm6lT8=;
        b=nQPLcvWTKEv9m6bU2gnbmL0Z5Xl+uN1PDyH7wgKPGjg8dtp6YZvRoUbCl/xdcBH4GS
         KV/OmMQHPUIddbLqvcmMpxZDrRd5ZBEyVBKdJeUuhGPN7p7gIn4yh1t9PIsk7aRwDO8m
         YIq7SUU2ue/bN1y7HI+BDF8Crl7ZF0rvwqSQrQ/vM1RT+DFBTIrqI0IZQzZh3LyuoApi
         r3hRt1tBbXOdMTg7+WdsnBSW+zjwXy1IkH6EQFtx91qVzEjLt4c2uc8pn8wf7x/47Q17
         FCmPW9I2kVLEIVvbk9AZG7kHMhTV3BZY9L+r52vMEY47cRhgutDEodoY21dCnBSGhgGh
         3iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986793; x=1778591593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CbKzX+LHwufFR/q2Jodm0JTpS+wKmq0Ba1unQGm6lT8=;
        b=YcMvGm/kFj06+xwsFMUzR81pUgMECDCVzVDi/th0DqxUKv8NVM+/g3rxZX/lLfOMXx
         vCn5U6k2EM0ipgp/t9QXDIttX21m0nPlaNxirw0RlyI/4AwNekg3euqwDGOzhOdJBOHQ
         /Sd32fnfgw28UpkxQX4ZTrqdv919pNvel3KlvVKvgrmFlZhzYZ1zZ0rVCHWUUnGP4cfv
         OdZFK6lJlDRS1KjNFAIaXVKGdluqjTtrTciLEfqB5/hW4r+eT/oFgdwuYG+rI97odlWo
         O5B1GDbyq9D9blSaWxi1n6TyvCOh3Fh97HDWXONcWJ+meYrWaY78V8uUgxH+vl+P71i/
         YJsg==
X-Forwarded-Encrypted: i=1; AFNElJ/QeEnshy1s1qKFER3kcJCmA/T60mDxuLSt8FbskBNt4yM30+pv0EZ/9RidYwAd5m9/wzV8FcyKeTZ7wyHMug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxhdHYpWc7nYiQUn5WuwE++ZJdM6eGr3eVzPPs4W5IcSBnVtcf
	Y+JBvyPym+3HbPqlgCnqz0WvctNOJP3/dmpOIKDn3ToTkVgU/ifjeKa8
X-Gm-Gg: AeBDieseAHz2XiiAylM/t8HGFOG7tPKVv5QxoBou+lPf+FhqnKIH2azA58zI6P4TDYH
	bcNYseRhSBhMWB61rOm/VxkwuS5YVgdEq5htGSgpJe05WrUxHmTfl+ScQkNrrvifR+LYUryC7Y4
	s/iktLPZwzl5dKyyDkP+dZMDvuuBtRAbOnOe1b7gvVFSdGtr0+965AUCSuVQRYvyou3dijd5CU9
	RHDf/O0rWdtRjkArnn4/sUVH3T7rJUxGmmAQaQ/gYI/lvswMGO81Vwdumwki5D0lOZvTChNUdxF
	uynMuMhlHrv3WLpHQ9+trRPDlzjJJjSWFAfj91w5I459hmZoU+XQciW9gfsnPM6n0rPNeM9myuF
	CJsUs4H6Tseuhbjfd1VxyO/DZ1D0Io3+OZIIFMiCLKr5Z44yovUecElNm5dM1EO+IZT63gPIavb
	smkeoEXgWoqg/rY6DWba2W0RLjTTpbHKXru23AVJ24pSo0lRg=
X-Received: by 2002:a05:7301:5789:b0:2c1:7afc:df06 with SMTP id 5a478bee46e88-2efb78d70c1mr6430271eec.5.1777986792552;
        Tue, 05 May 2026 06:13:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf67a3dsm20289695eec.27.2026.05.05.06.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:13:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 May 2026 06:13:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: Document Shikra watchdog
Message-ID: <bd44646d-a749-4014-9efc-9f6c0c13740e@roeck-us.net>
References: <20260501-shikra-wdog-binding-v1-1-fd8c14bc2d20@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-shikra-wdog-binding-v1-1-fd8c14bc2d20@oss.qualcomm.com>

On Fri, May 01, 2026 at 11:35:49PM +0530, Komal Bajaj wrote:
> Add devicetree binding for watchdog present on Qualcomm's Shikra SoC
> 
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied to my watchdog-next branch.

Thanks,
Guenter
