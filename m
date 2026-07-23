Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9F337107
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847668; cv=none; b=bGsomWUj/FxHBYXnUOkKlmcixOS25yxgVHnlY8LjBAiG0n8sGbk5XIUJKi9NmjoeWxEIj2iVjZjtOuOzooPOxxpggqcaRQyQMgJVBPvoc/UNM8u01xrnrsaREVkJGaHpYqlSV46/9QoDnCCU0tuo3QMA8a1CEMr5R6q3Phx9zX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847668; c=relaxed/simple;
	bh=tlBke9Zy/uEyVeFWT0u7I8al9pXAl3RJEyIr2Crpk00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlJXeKMYzaVsa29aZcMboMPlIXWc+QZwRpdAzr9tmc8FIuCOX0FEJ9/JL5Tf/TcC+E+PBzFmaEX6fx2qc4pcnHcLe50eAeCcLMBc5GakUrrXCSHhKPyltLs2ikYu46/cEEPRgRdGxQNcrGgPshrvaC056rZs1SZEiF9vIBVOEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdmT37Hf; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdmT37Hf"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbb973e6749so1433959a12.1
        for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 16:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784847666; x=1785452466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BT0tASgzzLFfHsQzTBG0WttYe9VxvxNAcJeWo1DWkME=;
        b=WdmT37HfVTDqw2hbcjawBt+Cq8m+FzZltIxWOeRed7i+LhX7qxTKS8+QdeHKxvnmaF
         fmoNFMCR6ca7z701GfLOX4RNaGaOA6TZX3u3WQCA8xXu4YO2T1S9lW/hxmzfiqxahGsF
         Qs8LtE0FVrqo+2i1f5+bogvBWjEhzRK8T2VtqeH/HjcMJrf9DZj6Rn3gxScOfD1gk5NA
         XJgOFiM/V7g8ltlKiEmK3m59QJNc/hwnbELYWvi7/9NwECErPfBU7hwIqa2FX4X4LIpJ
         ixqe+R6oVA87EI/kU6kclt25YfaSFrNL7DYX5fFBWfhRabEFlVF+K/23IBw4VfzHs+9D
         gi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784847666; x=1785452466;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BT0tASgzzLFfHsQzTBG0WttYe9VxvxNAcJeWo1DWkME=;
        b=EJIY0d/lpnox/Cib7WGyZLqCF+akxCx77+aBq57VdrOJ8lu1wqh1AAzOg/Ww2zeRpv
         MJeCzz3CZlls9PGcvzVxCxShXFd07UfH0z7o3geCQ9FnjQLStcL+bMR4pbWidvolKrUC
         gYQfLv2/vLa5iLFeC0L7iwPv460NnL9CMP9KIIHI1RKKYWI4uh1JKfj8GXrMis9zcwRz
         lj9EBuAcpSlUX5EXaxjkJZbzNWCkofZ0wBrWRr0vtF6nyKiTf85fMgTE0rNEuaCYqW4T
         DT0QijFnSBM5wSz2Ji/TAJWyH/WVEkkfjEmEMEvSmLPQ6Kk3cPbdEfzAknxxw2KwCIbW
         iSXw==
X-Forwarded-Encrypted: i=1; AHgh+RqygeV0fdFaJz25tYAPDT8KGhnrFajk0Mws3rDTo2fKB9QG1YCbzMkFDX2t3bbOkDCrzJlxGos5lbWHARWNRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycSEKxtU2IjLVWMLNpQHYrJyJabmAn5g6KR2vpslO110Cvghqe
	QVRmcP9DZ5duz/EbusiixQAvC3Z7gLrLhgd9rIv4upPR8CALsYSzPrAY3pAd2g==
X-Gm-Gg: AR+sD10Oa/WJ1/lHworzdZuo7R3nQhx2sfd5txQmc2Lwe4T4thkkCy0gJV5LJaWK5Wq
	HqxgJPt33/6IoLKO2HoawheCiF9USNCxkbh3XuwDrTFvcOLR28orL3+PARtU1hJTTdXuvWTQLeN
	2JaaAUS2gZjGS+QiFbFuNZ5lwWBK54WW1+y4FxKfUiFgm5qII7tRnZJQQdOWmI53JxxCjoeQV3J
	ajXgQKZIR3sQj6oHWUyb9RGYyPpNsVXMYuFelJlXqYg5l3682xq1OS+FXWLo/4PnUn5PTK+Dons
	IsdsrUipA2kVxUE1eLu1LB+Ff/W0aRoVTP5nKkNPe6UvV5TGmW4LgEBLZRIoMvsIyntW5Il8qhB
	MSjAO1RXMK5aJinFrbrn+59hus8EnFmvjBH/QB9Za57Qs74qvjMEu0jDKIDfEZTNyHly8/fn94l
	FBW5Rb4S4+r+mvDLI=
X-Received: by 2002:a05:6a21:6197:b0:3bf:6c08:2844 with SMTP id adf61e73a8af0-3c44b1ea25dmr5324085637.51.1784847665999;
        Thu, 23 Jul 2026 16:01:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d1302659fsm20045490c88.8.2026.07.23.16.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:01:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 23 Jul 2026 16:01:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: kr494167@gmail.com
Cc: wim@linux-watchdog.org, cl634@andestech.com,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: atcwdt200: fix return value when watchdog
 is enabled
Message-ID: <ef58b0e0-e397-4cc3-bac8-bb2e2f5253db@roeck-us.net>
References: <20260723022634.8642-1-kr494167@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723022634.8642-1-kr494167@gmail.com>

On Thu, Jul 23, 2026 at 07:56:34AM +0530, kr494167@gmail.com wrote:
> From: Surendra Singh Chouhan <kr494167@gmail.com>
> 
> atcwdt_get_int_timer_type() returned TMR_UNKNOWN (enum value 3) when
> CTRL_WDT_EN was set in the control register.
> 
> Because atcwdt_probe() checks "ret = atcwdt_get_int_timer_type(drv_data);
> if (ret) return ret;", returning TMR_UNKNOWN caused probe() to return 3
> instead of a valid negative error code.
> 
> Fix this by returning -EBUSY via dev_err_probe() when the watchdog is
> already enabled and update the kernel-doc description accordingly.
> 
> Fixes: e4e0848ad046 ("watchdog: atcwdt200: Add driver for Andes ATCWDT200")
> Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>

Applied. Next time please provide a change log.

Guenter
