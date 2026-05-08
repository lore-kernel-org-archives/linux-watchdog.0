Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DB351C09
	for <linux-watchdog@vger.kernel.org>; Fri,  8 May 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257885; cv=none; b=mPQfwoq1prX357wslz+Oat65nBsMHwT1jYZKWEqDWvgqpXcnLgrAsorPRQm0jtBmJT+qFQ3+3Wehd2LKML3CHaO2m4M+zQN4+BafhRyvFDlx+yJR6mL1xEG1JG6xcAzmbILqVOKEDxGfR5lfvoGmlE7gKwor40hO4hyaaK03TVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257885; c=relaxed/simple;
	bh=cnYyvwxEAyQwhgE+CAK7wrp3NPyRmDNXQKBPsfoKOLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNVD7R3MeJNUxWs0KyTIBezrGWb6hpnbFOYfwMAKLYjPMMpryD10iZCdxXLOmDea2c9+CaE3VyiieklffiK10Fwg9mUDtn6Vhto5mlOCY7m9wjnQfgtO8/Q7e7DqlWHwuKgxlMI7sHGcoSYS+5d/wVHna2g+GC29p7js5nVYnHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnOAzaiW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnOAzaiW"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so1147852a91.1
        for <linux-watchdog@vger.kernel.org>; Fri, 08 May 2026 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778257883; x=1778862683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19AaXry4CqS9DFRXnv8/hptHoDVw4WwhQoankIOrhwU=;
        b=lnOAzaiWr/1Q17a1lLdxkO2M7muV0CXMPNIOdXeppvNQXtZhtLbhNEUZ/HH0dYMQwa
         2SMtrR5TvaNsI4uUPp93QbiCtz3vQXvGKhsvhAwK0mnPBDUdZdld75YuM3x+Rycnau8E
         +aH2Dgd224IraW34blnKLrIPmetQ2KXsUeg2HMS7IZwiQuV03NrOw8sfd970DQ6b5zoa
         zZEoQk8erhQ/yqqNoydIC8/2tSjAQToim77eEzV8GPskgYeN99Aj5daP4Wbn7pZvSx/P
         2S6ykXEkl5f2JB9oOyfPq1vrDPV10S6RAH4QvY2UrEefXCGEkuAJgFYoMrMMqJjWEpml
         xzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257883; x=1778862683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=19AaXry4CqS9DFRXnv8/hptHoDVw4WwhQoankIOrhwU=;
        b=TFsyOnOVs2evLOVltKz/PfU3L7ajH71phLA7ChWXSbhz8EbyJKS1liPi+cGojkHY+i
         58NGtvaEMPD3lfikuHvm/f12Oe0fqIoybqREPYFBJCyIL3udYkVuttJVB79+9a7KZR6U
         D68AKeo1woA2CFnEv8tPuL8piNKnJcJPYHU8B/J1Cw5RQVjcoY7EYK2ST/4iNPJ5TnnV
         0CB+/1LepasqAHOHozcuZ8LQWaFCvGuRoDcLM+dz/pls/Fny4W5BdgZCd6PiGx14A2UO
         DUOLBThS7ww9p4rNaqT2Om6QLJBPVbJ3EnEBJmALoey+CoicvRz9rHDxgYjivSMHkUbd
         1oCA==
X-Forwarded-Encrypted: i=1; AFNElJ/94XkY2Na+Fr/+zRMjhj58V1TZc/25WnDfRoUHjd1FKuAikRqCdGnwC8LKt5g1DKAEJa7Q0IyVP31WUXwJBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMPVQmOiDl+uXzZ3DlUpVP/zFbCxP6gjLl5uwslVY/opeQ5Rm
	AkLSU9Ei5zkL2OM19Z+tZq0b39LhRgAfBq79jeo1qtoHx4UnmU+CyeG0wt9GNA==
X-Gm-Gg: Acq92OHl6NTaP2imu/MOrC2qe265l+4BAsZ1VrXeRJBbWBKHRVZia3WxHPrqG/et9sr
	Orq9qRuZYWDcca32YSl0o6D+JF5gtAQhvBxbNYOirsApkGgb6M8YEMsdWbMMGfhXDWCDepN3Ivz
	2n1ESej6hGuXqvi2LHTGbrKMQ96A1h1CdbpHGgVHW5qHazEw91IcuRvQaN++mVzqKTW1/A30QBW
	oRKu7vsiRl+ty7QP6jpNy08Vtf7rCWtL4oYBeQqX6WxX78iJaTDfq/9+217/q5OzwaG0ApeAMgA
	S/tTvHeWbPuNxKp39agonNDf/qTBuoAUdqDGll86WSkwB7csgYnMRjdMfvpSncMq7UCdjRotx1U
	UZ6FY5a6gJI3x8SvWzOMwjnevplKOc9PNTQAdT1otCcRMVij7v8lllBJgqi6lJmhKsGuT6WgtRP
	4mvQkD9c0cPb5Y1HvwJMjmpJxUTo7xgFGwUN8r
X-Received: by 2002:a17:903:3bcc:b0:2ba:4e84:976 with SMTP id d9443c01a7336-2ba78f45b67mr133077925ad.13.1778257883273;
        Fri, 08 May 2026 09:31:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e8eef3sm26769985ad.65.2026.05.08.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:31:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 8 May 2026 09:31:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4 3/4] watchdog: rzn1: remove now obsolete interrupt
 support
Message-ID: <6958a9c5-8ba7-49a1-bd49-1dc6e2f7b9f0@roeck-us.net>
References: <20260507102410.43384-1-wsa+renesas@sang-engineering.com>
 <20260507102410.43384-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507102410.43384-4-wsa+renesas@sang-engineering.com>

On Thu, May 07, 2026 at 12:24:08PM +0200, Wolfram Sang wrote:
> Previously, it was overlooked that the watchdog could reset the system
> directly. So, a workaround using the interrupt which called
> emergency_restart() was implemented. We now configure the controller
> when booting properly to allow watchdog resets directly. Thus, remove
> the interrupt workaround.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>

I don't think Sashiko's concern is warranted. Applied.

Thanks,
Guenter
