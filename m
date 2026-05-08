Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD12566F7
	for <linux-watchdog@vger.kernel.org>; Fri,  8 May 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257817; cv=none; b=Ov/ZlfsF2IRu1ZImAppwy9IropWvvfqVjc0aHcHtw3wL9uyTKT3yT3eZqUqBntS8PJv7bFT4WVsbHDVUJcKqJxoB7vaI802eyK6hwX62wDNphF5qFotjTTtflaMVYaIotgeLyrHhbQoLbkjFBme4NppO+hMCz3N/4Ef46OYGV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257817; c=relaxed/simple;
	bh=1WKhoWxPhpK3PawgeH4oavep5aWEmXj226jcjx+MT2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGLhgmSsyV+PbxD9zPZvnocfV2HQP5JfFcoOpJu49XIce+KEhFMgdM/vChiZJPX11y9zC1kYZPqo0HEhkaas7olWCF8NfXOtc0LT+SqZsJw1O8CnKUQYDVsdpJNXkljhUVgWku97JfR2JYAxDvM+z7lZM1fZ4PzyY5dD+g340lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGd6ujop; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGd6ujop"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b9705613ddso14707665ad.1
        for <linux-watchdog@vger.kernel.org>; Fri, 08 May 2026 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778257816; x=1778862616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hj8kaOVOLrv8kZO34jyZlQq86fjxrE1HGxSP8aPpbJ4=;
        b=eGd6ujopHp8pONaAnEiFdm+kmgTioPHmNcHq7q7XIi1CB4ilM1T2695nU9Fxi0SqHF
         Yzrwz5ElDbxdWTNKz/AP1+YG7tf5dGCYVLSb1ntGxdlBqfIl9mapn+fHcajhk9KQHEVn
         93cwGJ5sZps7ndlg2iW5JnJfrjyNRGTOfv7gEcU0tYBjatilKITVZlzUg1lUe06viXoB
         OLybqTuZLG2vz8NSKWfAfl48rOZizUy1LgwRxYXW8o9koAtSunHHCvKkszO8qvcdzWLX
         N3zoii8NlaaVMi74+bPXoxMcmDG8gAUYLFa6mRiugWGojzKGoPRRG+hQfL6ZQ9F+5WLy
         W+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257816; x=1778862616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hj8kaOVOLrv8kZO34jyZlQq86fjxrE1HGxSP8aPpbJ4=;
        b=TKo7rvizusGWDnD4e1kQobiJ9bZEllajE+2XaUKFqwS/WY+NcJRPaUY2vhtz9DLRVD
         HxwRuK6I9ywWn0Xa9FvIV3GeBv2335+nH009zFOKHAI6LwInDLwe0i0hxVQgC563cJw8
         lmcTq1cehM/9B4tFrM3aDuo6bFB6ViyZitdEZX0sQ8iK0PANyvkQYajkyEtZxgJPf94g
         TqHNwf+CteL8nTJrWS+snwJmZludmBVw9X8FfvzAc16EywFRYwYVAY5G2nwo/BU/4Lfd
         KynWrPaGeOZAj/1okJ5WKHoHb4KweSK9ubM4lanIKVKoe6lcoC46G5n24NaQ+T60bMKJ
         n5yw==
X-Forwarded-Encrypted: i=1; AFNElJ8hcY+yZpOQfL++XFK5UhlCb0h7Ko5jBX1aVJLX7mXCfMC7r06Se1NA9N11Cqx6yJoJV8fapEOHh915GCSFAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOJXYDv294d2eR4YXEgYd6pjUTqyhFTpZprScWJVXRAIRa6iFB
	pv0PP/SzlB6jgPxizKC6olW86MRmSDIiEoBiCIuMqgmgyJ1U+WwzQz7W
X-Gm-Gg: Acq92OGnVnvGSC6L04lvqK6wcFbuNjqizJj2rKIiTbhjnoo3uP9MbVN/zQNYgDvTdLv
	koj5IYymrIqgruLeIhpuksATFwIoDngOSGSaNngY7OHaG3Zg73WuvYySEtDOnNUWzAcyqJH88Ig
	gYBdwl20W3QavcgwwgzRozzCGaJ7NILhFt3Z9/JRq2T1HWQNrZPF+qlzChAJLp/smlsm4Rw4M4k
	NFh6wkKLulXBkKXVHyytLRALJChfr2EgzWJsJ6JsNpZvuVhSwI/JV5AUejvmGRDNER80APCqDr/
	PYhu6Rv6Cot7Z4C48pzCJecfoGAAUCGhU+KFq1jwH46xFdXjzBy8eG/Lg2zcNLtOxr6h9WJ5TTk
	TevOHq65QzfC0JkJQBekwohmxnyUEWei5tQqLfQDDb6QT5G0YLd133wfMpa5FU3toES6pACnY+E
	+erCoIA6KPm5LwEXtLaWXMCZCsjpiTWJYmrqC2bEuYC1i5Uc4=
X-Received: by 2002:a17:902:cf4c:b0:2b7:88d8:efde with SMTP id d9443c01a7336-2ba78f4e986mr127615525ad.7.1778257815659;
        Fri, 08 May 2026 09:30:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d40434sm27896365ad.29.2026.05.08.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:30:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 8 May 2026 09:30:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4 2/4] watchdog: rzn1: Use dev_err_probe()
Message-ID: <65d037e6-06f3-4f20-94f5-4fc1e21f76bd@roeck-us.net>
References: <20260507102410.43384-1-wsa+renesas@sang-engineering.com>
 <20260507102410.43384-3-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507102410.43384-3-wsa+renesas@sang-engineering.com>

On Thu, May 07, 2026 at 12:24:07PM +0200, Wolfram Sang wrote:
> From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
> 
> In the probe() function the following pattern is present several times:
> 	if (err) {
> 		dev_err(dev, ...);
> 		return err;
> 	}
> 
> Replace them by dev_err_probe() calls.
> 
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied.

Thanks,
Guenter
