Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50C3C73E5
	for <linux-watchdog@vger.kernel.org>; Thu,  7 May 2026 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161502; cv=none; b=PlcfZHLWrByrgRiavIj7+MDnPdclZbnbwXBRTNWkZZaiQvjctxhhoaqK4xnGoAp2YjdD3/mVEKuy6N7dxtvCWUuvOOV0Zt/oanUmjjLYYuwCC5Lw4pupXAWD8p9QzIx7qQHyJN3nQkxIwQa8ccTllYWQxl8Sr71hx9RZPF+Y0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161502; c=relaxed/simple;
	bh=pMGlFymBegAlv2AqkJTbUX2lINt3vsmDil7iM5LE5Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL38cPfeW1iIKw3sf44rrsbGO5WX6zsw/ByfxeifArHPzhVxM6VnQ/xfxQzen4b4F39P3KfLh3w3tdg95Hq8RNIqn76ExbUNeq1JUAu63cUDlyH/VH1Dpoh16tQfUrDoT1TWeTB8PUhJ8Inxtf/FZlkQv5md+r5IcSQJwB7iqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSsjE1IE; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSsjE1IE"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f33ae12f97so1551944eec.1
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2026 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161499; x=1778766299; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3gvAbGjCKrM/zU1MeUp6hm2Nga4EWVW956L8ybb2Z4=;
        b=jSsjE1IEbI9Pm6B5G1U79b+evnGjBjv1USsHFcSHQ9uquTCrcGypD1hSSLpkDgRfi+
         1fpUBMu2iqO5I/+e27Kz2pcPn+gYebB3EuBt2+Rt7jgOfY/1suHFExxShN73deQLsco0
         0k5J6kvTz4/ypdrbYUS3iI+KTjs/ngQpUk12W2M5v+XsS61yjXaD37dJv/HWWIVA98cD
         iOebmxnTUHcZAS4wTMgbRBRbHaBtuVgVGSxKVN9BB1XgcQPV266Q72VpohwEONlCTVH5
         2CRK4L1C6drK7EnbmlsdA3C0lRRkRCik8HdIVn4Pj6kXGEgtFWsovrxcgjboWrNpXMl9
         FcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161499; x=1778766299;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3gvAbGjCKrM/zU1MeUp6hm2Nga4EWVW956L8ybb2Z4=;
        b=rP2sQE9irbDRz99NY3XRhXOPhAxugwz1ktiSF47VjliEm14OTTM7SAc9ae3JHK06sy
         NscX+mYpCyTbNFLTp5oP//XEj7nieTolhL9AiTR8mFR9KS97q18nOvvO5oXcDxGwCMQP
         5UAIuE9vo0UCPa3QGCr9/Z05HYhKFzpqJwCvk4oXYmicuLVhOvm02dhdy8Sr/ivEBWLA
         dQ8YEuFhBHHrJ1iHHE4e3db0mA+8m7QCNP83I++eoWeoN9xfDBbHhwFWzP3qMRC4ya7K
         efcZYWz6cF+MOvG6S7OpQFo/SJnmutvKOmEzW2mH3kLpjFU9g9FKkYlDohBRqhrWEKSr
         Jcpg==
X-Forwarded-Encrypted: i=1; AFNElJ/9O8ic7lXFUprJYWEAjsxG392Ip2vjy37RpUyD+qwKpVHq4Yj8WSJJTcZkbRVgn/OViBm4XbH27XuOaQeAWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytywIOhUILKmbKtRcdGxdpLSkJvQsgDl7XS7FjIRERul1U09+E
	kVgBK8MXRAYhdAkrnndF8eTCpwJAoIS3Z8sM9SUo4S0cy3gGpZZvqntv
X-Gm-Gg: AeBDievHClvkfVQY5tgX793ol5oQI6TNPimRQ/hc/XCxEMmycvfhEP68QoYX0nkmj28
	r4xptrTGm7jt3U64BfvoGBFJbwS2ueKk+NlCKu1cwIG0QoSGw4KiZbEUC3aRv4HnlLUJYCjyvjq
	DA/dzmtzo27MLs/f8OUQfZXEuLoxjZv+jImCkeSz8o219IUCtRXyKed3FJqkDw5ga6YhduS9ICi
	TcfbvR2M/+47Dv+ZX0ic8NX8e1KDOIyrUrhWmDgvMvnk0W5jlILhwAiarE5aDcbJxO5AIfwrYXp
	fx1zVz7oFwQn7FyNRUuo9ZcjlcNJSk4zZtZNxZeeA5QbnIImIN3UiIeL7Jbq2HEmLijO5YA4q/R
	BJINYbY2SD0cB9dIVBE3NCrUkyLuunSdU/vo7qkZgLgdJKFZHIvUalC2HewGk2sMS757plL7m0L
	ivPTUh/CC8QfODO1B2wFAuVgIpJ+lCtMCwtVvz3C7mlcZmG9Y=
X-Received: by 2002:a05:7300:ac82:b0:2ef:9961:27fa with SMTP id 5a478bee46e88-2f54ad75680mr3949074eec.18.1778161499464;
        Thu, 07 May 2026 06:44:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56d8c45acsm8896385eec.13.2026.05.07.06.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:44:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 7 May 2026 06:44:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Fabio Estevam <festevam@gmail.com>, wim@linux-watchdog.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Fabio Estevam <festevam@nabladev.com>
Subject: Re: [PATCH v2] dt-bindings: watchdog: rockchip: Add RV1103B
 compatible
Message-ID: <c2c28437-ed52-4d67-b58b-9bca73e829aa@roeck-us.net>
References: <20260310002040.417424-1-festevam@gmail.com>
 <CAOMZO5DFWYUPN9sPzBr-W7fy8ZbrXP7u1sx=HrmUAQVCLrsdjQ@mail.gmail.com>
 <066e3058-5ba8-4695-9f45-523c7d43ab76@roeck-us.net>
 <5466403.V25eIC5XRa@phil>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5466403.V25eIC5XRa@phil>

On Thu, May 07, 2026 at 01:22:13PM +0200, Heiko Stuebner wrote:
> Am Freitag, 10. April 2026, 17:49:55 Mitteleuropäische Sommerzeit schrieb Guenter Roeck:
> > On 4/8/26 03:28, Fabio Estevam wrote:
> > > Hi Guenter,
> > > 
> > > On Mon, Mar 16, 2026 at 11:14 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >>
> > >> On 3/9/26 17:20, Fabio Estevam wrote:
> > >>> From: Fabio Estevam <festevam@nabladev.com>
> > >>>
> > >>> The RV1103B watchdog is compatible with the existing DesignWare Watchdog
> > >>> binding. Add the rockchip,rv1103b-wdt compatible string.
> > >>>
> > >>> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> > >>
> > >> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > Could you please apply this one?
> > 
> > Wim applies watchdog subsystem patches.
> 
> seems to have changed, as it was applied as
>   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/commit/?h=watchdog-next&id=882fc25d868fbd0d71751df4df49c4b55e3fa230
> 

That is correct. I have been unable to reach Wim for several months, and he
did not send a pull request for v7.1, so I announced last week that I plan
to handle pull requests starting with v7.2.

Note that my tree is not yet merged into linux-next.

Guenter
