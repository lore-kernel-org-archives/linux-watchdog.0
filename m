Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC759D630
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988950; cv=none; b=Zk4WBX3fojUr+Lh87aIUTPJf2mP+XJof6NSepXgnDde9Y5/rcuUL8tlDWOXK1ADs6ycZcKdPaRDeXaGkgp7aTR/aDfcqFsAXL0uWII3CD5F41azQTqxFDJb9DlqUHmae06EtFRuuzsVICw8lF6YI8FduetsdVkMYREgsNMUK0Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988950; c=relaxed/simple;
	bh=HtNWfnxnDSSWJZCxMLyZKzkG5I6ufKDMc1VO13LdMqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxOryCFlcgqZwJER4aDTcGwMZLSzeDkqF6wbLqEX4pTOeBZtCIpiDGUDck7hKftRGRiHEBwftSHoTxcD3fa18fnd+40JqgEfedy/koZ4THu3ogXVQ5fzd5/9IC2BTk9AiUuk60T7SKVCA5Ylj9EiTj+nkrCw07PuqQ2yFOMUxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4eg2CVk; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4eg2CVk"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc149372c14so3338821a12.1
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788988949; x=1789593749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OS/hMmRgJkhO3y6TipOYJ+hU/luwN7sov3GRLXL60Lg=;
        b=F4eg2CVkgNsS3lq5doiVXybDz1N4VTjpS1THKGLHkod3X9W2/d5xV5G+oVMrq7vPIH
         eGy8vMC++yCJ5dHHnNc/6AfMO7evKMGlRpd0xRICxALcDhS44xCTFIgeylQ7PP79XLvd
         G1lZuxEfDbBJ+3MJk+YQHS4CbTV3EKBhsEPCE0rWkzChJztU4NbKLQA6+sJPrpX7rMMg
         tZurWg52PcdsF758xuAhC5WS+Q73DjyiijOBapFDCN5V/Ikzu3rYPdzOSqf5MUJoMrKS
         VTJyPVhPkjQRTDtM4iiaSHQoAYjQ6IwqRHOCsVpYrArZmCvyE0t6yYt0B5beNc1y1rH4
         oNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988949; x=1789593749;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS/hMmRgJkhO3y6TipOYJ+hU/luwN7sov3GRLXL60Lg=;
        b=igzw6iTUgF3xYg0G0YSL6krQG7mimSL1fswcaG2BE5muNTsB/qqy8OOnW0jejuX4Ef
         HRp8FwbE4AndjNGmPzT0goLtVlf9qpt1oZYCZMIsBMBYVvzR2qfjHX0S4VPWUzOBeoWQ
         J1NpsuETLYdeLMswyhqZ84e+gLwqAn6E60XTiTx7gEXTjsbe2Ck+HZ0tmZAwK+shEkxG
         0Th+fZfqAbq0N7IFwmL5ddhdLLiI+7i3S1QYeM30idaAHCbM1mULBDARzLi8F3ynpWbE
         idd2ZFIQfwrmoho7seTHFoxmljuUbUpZxfXtpFNakAMAy8YV4SCRMHlbZvVLrlRS5R9Y
         J/0A==
X-Forwarded-Encrypted: i=1; AKwUvBwljrByHwjiZtfn1E0WJODB9sUkD106KL2m89dn9XB3sDM8u3nQnH+Af0XjK0nK7kTXAgrDj9fgin03eopOtQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lHYuTpmHI9uPSSn9XktjtNNX8z7q2zmrAhI3/84gqXoabTnlkf
	L07D7lP9IpyWkUkShsp5mYs+U+v+Oe4I8tvpqg9ETi1yb/C3ByT+wLHc
X-Gm-Gg: AYBFou2n7zcBuF880OxylkduOxJ4hcoXlw5fkuJKiBt2wI8oNZjJ3yWY5SFxoEsYb0h
	HuTWosO1q0M70ZwBvoKAbq5e/4X1dOxVAecgFTbi35qojfkeoMu9ErpeM0oJRV79ByERyjavH0o
	burXxqEMHShPOC4niP7YMfSS4a6sbiqTOoOtBgEBBFQECEx7bu5Vm99Q7koeFzSJxvNJzCy6NcZ
	vE+H4qpla+yVbqEBuJ/tmhJeyOR+zvyAJL1+8ISSGQKKlOaoXnkmk5xO2AxiAwT4LL77bABHeOw
	lhD68f0w+lA/lL+TmudESwPeYYTu76VDdULDjQsP5Qu2m2IXVUylxZP9CoPGOqSGXOes9fA8dGI
	qEVKrsfLpw4YZeKFQV497D2+PBxRdQx1ebwBQsJl1lrVLyYxCYEabbCMNjpSWLIVj5JrDqw8Pe2
	n3xBr1Oy6ffJ1RxAAy6wsqXu+dE8MM1DwvsTdIvk0ktDoxUYWMZ1TtKXLfZNqApccak0CNapBJf
	yKXNOfHow9mOA==
X-Received: by 2002:a05:6a21:710c:b0:3cc:b26a:7686 with SMTP id adf61e73a8af0-3da39b5c435mr58092012637.6.1788988948772;
        Wed, 09 Sep 2026 14:22:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc455406f14sm7598314a12.5.2026.09.09.14.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:22:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 14:22:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] watchdog: msc313e: Replace commas with semicolons
 in probe()
Message-ID: <a0514941-f112-4cd1-8683-66ea59cd894b@roeck-us.net>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-10-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828161348.13212-10-tzungbi@kernel.org>

On Sat, Aug 29, 2026 at 12:13:48AM +0800, Tzung-Bi Shih wrote:
> Replace commas at the end of statements with semicolons in probe().
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Thanks,
Guenter
