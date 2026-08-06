Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2442589F
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051488; cv=none; b=OqF07O4OhIKWc2cLHgrsZwYJz3aL4zTmO+X+mLhMwA5qdNuwfG2fvjp9M76vauDQk+nrBsOUTBKyhIs/J+qy4TwHXzdYbDM1RrKuoSitgq7RC5xge8VnLvBGi5HmPxCML61aqkuimGPWD9heca7iXhnIHkdQ6tmmDPVPwYInQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051488; c=relaxed/simple;
	bh=jiitxNmie6YJrcx3KKmGc64ZYpttCGkHLQkQXPhCcY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIRYBf0m8XHFjKn1eWgSLobP8t3smGTQOEvPVXSvGe9ySwx0Aqss7/Cs3MonkBqBjqRnfNeluz1JYYYsDgNlN7Ji2poqnW/LAK63rr+2iSZsRNcQhIDKjdGaq03q/IDAdSr2ruWotxKwPx2oAkMwzKXBCxBMHfhyL8qrxS8ACoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xcq9fRqd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xcq9fRqd"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceb096e675so33589585ad.0
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786051485; x=1786656285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xvIZQs5aIdeQIGe604/g6ihtAuOgYCCmz8WzaoFmYew=;
        b=Xcq9fRqdrwAEIIQ8RnsgLLp5NJ4U2SgxH/TMXOawd5SC2FXI5t1HlyMtWuqne3OYum
         n07SzzRQpwCny+yQuNHxOPkFAiVvaZYSCy5VYIuPfMImUE7rEOSwKJFNluf8789jhb2q
         hdgXs3XxGpfTBcSf/hjyP7cRaF6OMkc2pgn6iq8PqmZaYo6VPzJbTtOTK3tuxO+4ubfa
         AcY3BYhkjz96ZQYmz0vgnWfCnuLGT7LUYIIdjb4lfMpMH0iCx2QDPTnu2jl3RXxZ2KL3
         w8m0HEWUnZ4P74Tb75l2ta/csaTocHHBSNO2C4vB2/8E+m+UG1JaANy7xrA5U+Fw2o30
         Dvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051485; x=1786656285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xvIZQs5aIdeQIGe604/g6ihtAuOgYCCmz8WzaoFmYew=;
        b=VTjC74mAm2S2/hw7PVYoXWNIaV0KBIHMDEjBEwZtAyC6p/kLAHGPnddXTHRuNSPlYo
         nZltFd2xjwYvp41LA/cJBTZVuN+BR4rOdOhCkWbZOo8TySzKVpH9ect+oJuyYIV0jsCf
         1AVLFvVgtS+nyq7zBlsl5b4Ccx6XItgeNlOTsDot/bB8n9nycpYzCCya0vgLxXZnyX9+
         wICimflmkekd9xSTec4aE3bbYICv+5usNzn3CqUhmfhpm6twZn44L9iIx76hjNKyXmX7
         A6Sn0PBwJmV+fhwzNW8SFXzucs4EacgsuDNiLdKfzEE9BKqFM9way3MBF7G00Sg55+zc
         M3lw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7z0qsOMNUfd6NHtKT85B74oaPTPqMhOUFbI1ebDdlEJmtgpMnoxxgMP/Rq9zh0ZMJNGk3Y3b1dBpetC3hVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRVdvPIJnV+Yhb7Fc7ZN8kXNSczXiRUrxXoQniFda0w5uacG1
	/N2pUi1+rIyBkRcmDMTY4lg9duH1TgJjYQBzoyJMs+aHK1U3JJGQ1g4P
X-Gm-Gg: AR+sD11YgkaXK1D1WoZsns21/3BThfGzK5At/qV1O5fdG1MprtSJB4gKgPxsB4GN2Wf
	HAJsSSl/hi/j9w+zDk0/5cYmfC7k9W85EUx3OIjLj7kA2/Gh4fMbRA9qjBWLFQbmrsyBywPgVax
	PP2J//pbcMwguHaYS6oqIwJAZYkXiT4tO56qZGBG+2yFro8ZBTS2+X76XvRKUKvk4xIm8UE89t0
	XruwvexVAjWDVSpH/R77cZv6bt8PVVR+UsgZ0VqNeZhl74AtM+XYTcYfUotWUnqx6qmmFjlHL5p
	icxOI4/xjAbQrO21bKvIbMb5Pmq7kySkFQN+uzP9saZNguAwVuJke5RneZQbLYCI5jdJY/BTxeT
	WUDOAiYNi+XJfuxVqmMMf0mAL4qYMlhSLnkZckXQODmcb7psRnPzvApNEADcXh2ZkrbbmDMH8AJ
	B9Y4wYUGwdxLHpBjUddxbupgn5b0HLiggMNcJvwpoE/InRxGW6KjaUjID6++xDfrfi6OLp+0K8M
	Q==
X-Received: by 2002:a17:903:2301:b0:2c9:ff29:3f91 with SMTP id d9443c01a7336-2d0ca7afc9fmr179070215ad.6.1786051485151;
        Thu, 06 Aug 2026 14:24:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbed969sm189185ad.54.2026.08.06.14.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:24:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 14:24:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: watchdog: Add MA35D1 Watchdog
Message-ID: <114ad2d9-322a-42e9-ac8e-6e6c7b451a27@roeck-us.net>
References: <20260804070351.1846165-1-zychennvt@gmail.com>
 <20260804070351.1846165-2-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804070351.1846165-2-zychennvt@gmail.com>

On Tue, Aug 04, 2026 at 03:03:49PM +0800, Zi-Yu Chen wrote:
> Add device tree binding documentation for the watchdog timer (WDT)
> controller found on Nuvoton MA35D1 SoC.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>

Applied.

Thanks,
Guenter
