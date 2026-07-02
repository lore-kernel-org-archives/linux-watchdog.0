Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009F4C77DF
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001603; cv=none; b=DgR0KX9ii5pTFl3bfl/FMiZBeQEG7XSeY37Yyb9XOf71JFOE5zMZbB/C8qIDliracMKUdVFj5CvWzoOtc6YjpY2uiZ4Wfq1hFPcD67syDEDTQ62aov4dKs2gwxFRpSn/S+u0j2xqwNlktHbPw+pa91DLDSTTvc6l00td5enWCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001603; c=relaxed/simple;
	bh=Pg2lqWXp76Badtsi2DF7GRbFExK4NjUhM71ibyIo/70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYzsZ6GNROJdwqY+7UJ8Cmlj1EpftV78VfrdGDCPnk7fY6PReqt29gC8BcE3c2rH+b3LsMPpXUkgV8K4BYw5m3vWNuY8cIPaDo6gSnpOQFIURRB0I7Fcgii9dnK/3OqBZYnt4lcaamaxdFFfxGyUdUwMRe6asdrcmCr4Gxex3cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee+PH7u/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee+PH7u/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c9ed0c7fc7so22639295ad.1
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783001597; x=1783606397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wz4agU0yn9wkoZiN7DYnByNy4LBmnpfOWuBui52/YVg=;
        b=ee+PH7u/RbYlwtKfM7WOe/SEq7tQKbgqxqPpWgTIeXnAIBaP5zY46EPrSmHJASgX38
         uv5Bk7RsZ3EjTrb63Chj0rrKgKQQIi8YRgbSE7flI3Ydl/gA1oXykpmJ52tnj22JYzKU
         XRSic0QVVZBTlXUoHhPReV1tYPzh9BzDgmjA7pKoCssyCoBnzyl1qOxy5Zma0XwNRL+a
         CKeYutDjAuZAP0fYUUda8CEgy1nBim00n9Dg8xx59HJ9phGWO20A348/9aDFTc1JGRwK
         +KmJOzvjGTg/oz2QEjxaw0lG4N4iYHwJ1iNi7/Fdyer8tptKB3vSWyBVzOGNftiJm1ay
         iA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783001597; x=1783606397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wz4agU0yn9wkoZiN7DYnByNy4LBmnpfOWuBui52/YVg=;
        b=Hfz0tgEoqRXka/SN0M31Xy6D7VVUeQQ9sAHLjcn22+JpR2E8pZXGv0coKV28jnCTrz
         7LyJ27KdkS+HsGRzT/11NMnBfZ9DkKUvng0OHzvqyvLPCWLlwTQjkS3bMxTUUVDAOpGv
         ETAbe0LXNjVIXG5CvnZk1fZ8cOkcRsbGQRBT9+Tr7sZt4W5TfXPnx/RSMDR3jeD4S37p
         krbQ1ULi0MVH4vRzkl3GeIiRkBT7M2+BSA1/M8ASNeNOKSdK0Uiv2UgS2sPhK4tGuyW6
         WhSMM+s3QqPR/Mewsv1PAWxn0HcZ7UXkE786N3iFEtzjdsCAVqV0m9n1UdabDF6X9MLi
         Me0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoGJ9rDzdHSYj3acq0ajeVbz/nvBpRblnMzRG/g7mMOws5sm/N32EmbQdA+6dK5ImPhCeYqOtKOefjy5npO4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ceb09jrgxVYFrjN4HCybocGoE5V8IxQHD81iIEPykb7JsPDk
	sYOeuzDRNKVhG8q+Tcfw/rynY/Rqq+LgCC6WQRwyAMnKbD5tI2eFL4I2
X-Gm-Gg: AfdE7cmGeu2z99EH6G6y+oLfeaUECWP1W9eeZ4mK/MLXgGy3EzAOb6GVI9ag/if2Xbk
	4lPy1RV7xq/cjh/NBLozKZPhEssvABEYZ2WzdV2HEQe3kmB36cIA8XanLCdsc6dQtl2QNohkzAj
	VFKSifnF6rpIYSDJ/vOELQbi9mqllB4VmK/PdpJj6DNKcMaQrL09THFmlyccMEbDzRmEXHy1orh
	fUXQP8v/c7zFxlRil8RTh4tg6jiiw5KnB7oYM++2KNHMCUG9PHMI+k15kbODN097Gp3q+uYBh+2
	IFrbfgNeQNAPkgo5BlEXjEHvvA5W67p6rrNK8O+gwO2/OMpar7n+B6XrVL716jjp/wlSAE6UT1G
	nPgf6iipfI0smHCaG3l7soJTN7HbRVrdK+MyE8zow4yrKCj6LKcRF2EO/0zW5VmpX2iIaiy1rx6
	KGkyCF1uDSTIOpvrDd14PiFqhqnQ==
X-Received: by 2002:a17:902:fc44:b0:2c9:dbb5:c1ec with SMTP id d9443c01a7336-2ca7e8b5334mr69557085ad.47.1783001597445;
        Thu, 02 Jul 2026 07:13:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a90ca0esm14205725ad.27.2026.07.02.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:13:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Jul 2026 07:13:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] docs: watchdog: Fix brackets
Message-ID: <645105c6-0302-4ab9-a249-09a4036d6409@roeck-us.net>
References: <20260627091707.29688-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627091707.29688-2-manuelebner@mailbox.org>

On Sat, Jun 27, 2026 at 11:17:08AM +0200, Manuel Ebner wrote:
> Add missing brackets ')'.
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Applied.

Guenter

> ---
>  Documentation/watchdog/watchdog-parameters.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
> index 2359aa32e25d..8e2df5b7d241 100644
> --- a/Documentation/watchdog/watchdog-parameters.rst
> +++ b/Documentation/watchdog/watchdog-parameters.rst
> @@ -59,7 +59,7 @@ advantechwdt:
>  
>  alim1535_wdt:
>      timeout:
> -	Watchdog timeout in seconds. (0 < timeout < 18000, default=60
> +	Watchdog timeout in seconds. (0 < timeout < 18000, default=60)
>      nowayout:
>  	Watchdog cannot be stopped once started
>  	(default=kernel config parameter)
> @@ -68,7 +68,7 @@ alim1535_wdt:
>  
>  alim7101_wdt:
>      timeout:
> -	Watchdog timeout in seconds. (1<=timeout<=3600, default=30
> +	Watchdog timeout in seconds. (1<=timeout<=3600, default=30)
>      use_gpio:
>  	Use the gpio watchdog (required by old cobalt boards).
>  	default=0/off/no
