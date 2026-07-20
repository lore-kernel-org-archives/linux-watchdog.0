Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4540FDAD
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563806; cv=none; b=HY9Ug+A0qQ33GFEF0AG2mO+JfX3FLx7RB57yoFmM5yCs8ztWg9+L8OGzAE3VPm5mq4eqtV8hly4cH1SggEJ7qMZNHlxI+nsPRcIQGhGGk6byxWQJANx9FItUbj/cD8/Nn5P9iBy6a7rjPDWwYoqBMgqkntFqvXlvmjLreoFEnUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563806; c=relaxed/simple;
	bh=wFJ2G2Nx9gaZnhcJciXnJKtKTiKxKkOSK5x9fJBL0+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyJ/Hktolxphpsy4qrDzOPQLYWN3CN22eWGpTAVwvi4SEl5Jc2ANr4Y7CZMFMLpskRVTT6Rh4M0RLqsVd2fd2Ml4QIY15/mqOW4Vo+xLV+jfMO0UeZ/gh7wrDImYpizhWvtL0YxSQkaHQyb8ZjrRQkoSbyN0LYQUNIGv83SxuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5Tl0y8x; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Tl0y8x"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf50c6f235so20992185ad.0
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784563801; x=1785168601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p84L8EQrf1/Bk8g06gBQbk74BG6TjMtTjLqNj/+ZjME=;
        b=A5Tl0y8xGFhmOae9NaaTLDmK7o+XPuBytKDpA2BWnjEagaZ+vrZia1CNgjtgAoz3Z7
         W3+tMa1LN5T1Ny+xUgRqU8J5l0R/CHUxFjhAJe/xv67q/5q4ClGgl9NtDUEUCeqFznCi
         ztMZgXTtbsmaW00SvSp0m3fJo/6SGUYENJNTvFsbalD/SJW+8SAvWpt/5AGaAkOiNEXv
         U9Z34JKs02kecD1zrg0gMEJdqhHtou6p339+peFRNkKqiyn4efww8cq6C1gZy42YfSzN
         nQhYzNwiaB1B2LtYRie1NR2Pp3LIkgF2QWOnV7GAvKMMF67Ckk6grMyHJN8dHg//iV9z
         Dp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563801; x=1785168601;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p84L8EQrf1/Bk8g06gBQbk74BG6TjMtTjLqNj/+ZjME=;
        b=AKRVYARR8ZxBf/AhDwKTOmuL20xHeCHzeE4Cew4KFLDQ8KbGhyVimzBMa76kpI3XqT
         roLdYtSEDQ68R4Tpd9RlyAPXjPan2a9LCBgVxd87yLyFw797SRnq5OlXofG6GqUgbzW2
         KmMTU69k63Ik5nbwPSvWElu4WDXjppI/AhO4Ut11qE4dFbxBkxMkREf3A2FXzViJkjuM
         ikFE1EkuIiZK1Iv6e955SqTZkcPqxBz1OXE9uobc5a5ggN2nZS+G5b7JWH1JDH2pB7uD
         nrRBVsX+6eSdU2wVglOm7kcS5VzY+V2QCPTlnG0wFq81sJFueDMd3KukfmRWU+ys8AKK
         BkyA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3XtxQRniwLw272kOoixPKSvFw0o4XOg0L+SUUwwEhfBf4+kSivwgtnGAriHsy6aDzEVz7RbBSJ7CzCJCVQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTHW+jgfhS5HtqjAZtFxPUwggGTSIQY2j3suVaBwEAnvhubBw
	/WJ4FwFo4/bjPW8aOwOj36Ps/YLcXJoOIiiwZdiNFreC0etQV3h65qRW
X-Gm-Gg: AR+sD13Wh0BbOK4p9B9YyvAq4b+6yiJRPg6U9UD6P8Og0GJahZvkGneOnXzqZ5esJzA
	rLfJmUs0Hk+3rHtfDK/3hMEasIO3miF7uYqzs+xiUIyhqLJEbN4NunGK0lcfKv4/0vh3K/Mq/KN
	kSKBrq7ceYT4ICiLjipv+rm3+N90blblcc34hAO0ybSQfuUQxQ79py6HO1ct01GsjmG2CeBEGZD
	DWUqS1eVIP7eTq14A0Wy3ilFQLOgX59Y2BwmNgPk3T3hcc6HEOl56Zdf/2jD/bqpTZbb8SsWU1x
	49K4lfnbHhMNvjyUPtR7Y7rfZnT2kGNm8Pn86thR1LTIkDECyAyaGeP9PgosAfl0NQYImapBZM5
	6QoMC8ngTOUP0zpvcjnBHBAxYtWNKeo0Vy8+4WGc3YRZhFTTqdI8m7pkeq1BR8ad8jPHZ7z4lq/
	1ZIEYWNNMVgayHhxQ=
X-Received: by 2002:a17:902:f786:b0:2ca:caa5:9c04 with SMTP id d9443c01a7336-2cf3495ffccmr169921345ad.23.1784563800862;
        Mon, 20 Jul 2026 09:10:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d439sm45256293eec.5.2026.07.20.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:10:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 09:09:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: andrew@codeconstruct.com.au, wim@linux-watchdog.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, openbmc@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
	yuenn@google.com, benjaminfair@google.com, corbet@lwn.net,
	skhan@linuxfoundation.org, joel@jms.id.au
Subject: Re: [PATCH v4 1/3] dt-bindings: watchdog: npcm: add GCR syscon
 property
Message-ID: <d79b16b6-9179-4b88-b401-66a177774c00@roeck-us.net>
References: <20260706144828.3517631-1-tmaimon77@gmail.com>
 <20260706144828.3517631-2-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706144828.3517631-2-tmaimon77@gmail.com>

On Mon, Jul 06, 2026 at 05:48:26PM +0300, Tomer Maimon wrote:
> NPCM750 and NPCM845 latch watchdog reset indications in the SoC
> GCR block rather than in the watchdog block itself.
> 
> Add the optional nuvoton,sysgcr phandle so watchdog nodes can
> reference the shared GCR reset-status registers that hold those
> latched watchdog reset indications.
> 
> This is needed by the following reset-status support, which reads
> those latches and reports watchdog-caused resets through bootstatus.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter
