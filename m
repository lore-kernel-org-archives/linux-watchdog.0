Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3E2E282B
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986913; cv=none; b=A+4lsnAZ/A6CRY+EesxgUlWGyrXsAGugmiYT6JSmn7q3ZGykzx0ncy6a496xnZze4rq39O/1EM13bvVUQEuE+WsLImihpPGF/Veok2cZ3iMKJ9FsvqH87l0GwxPKXskoJ+KG+TxboSs+haq408x6HwrjoR8C+sg0XW+mh9XAm3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986913; c=relaxed/simple;
	bh=sh2xCTBorGQ2JR3568s2B3e0a0qJVN9ciLWcRAZPteM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofc3sx8XnU4nTN/uUBvvoNYQveMtE+QYxvyFGdydnyzf/4Fw/BcMktY3oZWvNaLrCck5PLVb8NxO+EkUL4q8pRGFuWm68nvZObmTkcF5KuBIY5jVvMrD3jkJ8AOswPmhhZbZqtqltP2ARsbAAGZ82CtvzT8ql0xBeSUQWwnmqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spTdqt82; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spTdqt82"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba895adfeaso5611579eec.0
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777986911; x=1778591711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiCzRscPiaONgd2D8Z0izVU1thK6ExvhNDyi9r/WhTw=;
        b=spTdqt82VBG12py7sSR+8sDWLkUgzIq53HW3SJsrxAsfsG6lTO7f98T8Z61JO5DYTy
         OMTMoD01fG/SIer8ivBB6jtfWfx6zUlcOtFlGTRqsdc+4JpLwJK/uzLSojvzf5ukYOvE
         6itTwa9Ycdwpu2awFbDobyv5z4D8+HWT/Q5deV0Bhv+AH+682tEEtNyZfBlWms8yUJAm
         jwPezwIff+wnc9QDTFjMHVH906M6OnKvL2KUUsN0WjTU9lHX5yd+/W5nOnNV6/UDzOs3
         iekA2W1Mi6ZOB6Q6NXSbAIcF7JwqqjdTsKs7JotzP4XsvlwfO8OEWxBDlRzOWSlQI+++
         cgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986911; x=1778591711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OiCzRscPiaONgd2D8Z0izVU1thK6ExvhNDyi9r/WhTw=;
        b=gIwroQquG/Ksse68yaCrKycGv09/cymb9AhbgnVFEfkQpIzHWyDkioc+NVZNZmnEDF
         LlPlv08L5zpgNdLz0D2TqhwrIjwH64LbPuXVq0Ry7D0x4ll7B3j4tpie7MpVhhEGdvAS
         yAeYF3BufS0AdTxE2jx+xw/F5HvmUfY8ZmyF3khQYkApsfr89jHtZF57TPyyypQRfcro
         ov7vksdhx2Hmy/zEiOhAvQyD2Ik5ISS/Ypinsac8M73K4LkxwUVcQ5K/N7Eh3Kua1QyQ
         Hn6hmB0aO2IE4Cxu7eAVKPNnVaBQ7WTB9jezNPjw0bv7rkIvExw5FVBQIHY2YACckKLT
         EUvw==
X-Forwarded-Encrypted: i=1; AFNElJ+DrwCE0bp7mZ7OK32ImJzaOOp3vzjjZ3z940XPhDGI6uPXlz5o8xI15Moc+oZI7AgHZ6bSMUmkhgV1FyCt6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8vmqlzfJz5WnGMlxKKTZSBC3rTdoNzV8DeG5W0Jz0tuW99LBt
	O+KQSuI2V5/kJXCz9HKiQ46BuPGaFFR2Ogt+kXSa8PNaHvnC7Ms43TPP
X-Gm-Gg: AeBDiet6yoVVUEYdiW9c8hQs0gak6oxJHxQpIQVOKuxVYRQ80AkVSFkBLgmYTyyWtkL
	VJT8RajHFpW6FT8Vi81ydsKLUw1j4MSn8Z9dQLEFIYiV315e/VVMvXNiN55pVPl/YnwPNloS1Ad
	pvgePpjCuDLz7jPjVkIsC8ewJ3e/40kZvdqnskBq7qWtIsH9My/24+6miiVjcfHchtv6qiVGUM1
	Gx7aQqeJ3zmrDTz3S+eGsuibPUygnbvqu9kUryfeQJCFdmLbuATp7pGhus8w71AYolMdcl5Wgov
	rxgZG/H3u53ThN7mKSWm7fa+P71bWwQB3wunY1QRXRfBq4u5EiSwe9xpDF1tCojlpsbxTsRTjTm
	WSK28gVrNteEsorLG5/fPZIl3H4+clp/05aVyDdjb2LTDNe3eQwQPp9AyqKt5nMIwY1wTg/h86C
	GwE58lF+3wrD9KGUT79XxiME2BRhkC5WMSn4HCnD+d4Uc6Hu0=
X-Received: by 2002:a05:7300:a49a:b0:2d2:129a:1694 with SMTP id 5a478bee46e88-2efb9e7bb88mr6293010eec.18.1777986911009;
        Tue, 05 May 2026 06:15:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b1a4sm20342305eec.18.2026.05.05.06.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:15:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 May 2026 06:15:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: lenovo_se10_wdt: Fix use-after-free and
 resource leak risk
Message-ID: <975e78c6-1898-472e-ba39-1721e2555940@roeck-us.net>
References: <mpearson-lenovo@squebb.ca>
 <20260504180159.999189-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504180159.999189-1-mpearson-lenovo@squebb.ca>

On Mon, May 04, 2026 at 02:01:42PM -0400, Mark Pearson wrote:
> Review by sashiko.dev highlighted potential use after free and resource
> leak instances.
> 
> Set se10_pdev to null to prevent use after free
> 
> Remove DMI call back and instead directly call
> se10_create_platform_device. Handle error cases appropriately
> 
> Link: https://sashiko.dev/#/patchset/20260428124954.1193450-1-mpearson-lenovo%40squebb.ca
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Applied to my watchdog-next branch.

Thanks,
Guenter
