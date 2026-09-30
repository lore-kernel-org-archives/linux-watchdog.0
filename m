Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399854D37B9
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771844; cv=none; b=WesJH+B/WvzachUdJutvyEvf/uRL8coDrWH5EKNWfeq96Rt7cQAhESNJg3jhOLeSaUyt/bb5gIii7gVqIIhuanY6JrFMjv3afelQhsMq+hG6h1YL/Ox0gsY2OUV8jmCC6iljNASicXg6FQoeaXhf+udZ79AVXIAuitnt4Hen078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771844; c=relaxed/simple;
	bh=p40B9btGReopRpM1Nfv5c+MJXT5wn0yzDEiLh9/dHYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryzuLd0QiFBOCQ3FnrCyK8453O2dORTBfPbtXgprmT+uk2Pk5Y9OLOzOzZqb/zewiJR5SrjDaqCOtcSgClDCyUq0pNKdf7AABoUEAWwR2K3OvN4s17Dpe1WSlk/YiTrp2cd7zJP7yad7iPNbLLhlWzAQ0GxlK90BWlEKhZnhj2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYJgBilU; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYJgBilU"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e44so1801379a12.2
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790771842; x=1791376642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rq7mO0SajJJKY+1t6hXRwZfv5jk5Yv3qT3TLkdzP258=;
        b=AYJgBilUZn7sAHQUw2hn0Kcyx8GNhbR4+1s+mTPWJFDdKPnI2YKOVwBLEHCIpgKBH2
         V/faNTuY8o6ddDg0cYqhJTUxVequPDJmNUaNgmqgps/bh9HjpdbFCsqJA4Vl6IHFDElQ
         Lm9L7F2zgYb9TynjIp4m5aYaVygKpM/Rut6gymFyuawrIXNOrGJqmQwus9F1tgYFamH1
         yh1mvNclX1ASGLjCAdvbSlsxrhexC80LDV5szl0PShQuZOUbmAc4uedtr75CajR/2/oL
         I7uyq0p5gh7R/4km2jRbFWV0QCPJssDrCFKwOeyynp2dYn4flEPQ2FdP4fELeXXQ71OX
         B03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790771842; x=1791376642;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rq7mO0SajJJKY+1t6hXRwZfv5jk5Yv3qT3TLkdzP258=;
        b=aUzPqyyWbQEGMPNXDUUwu+Hi2V9pb52eUJtMTe+e/Pp8UIARn7VWRfRCzVsxbqyxgi
         lzMllASjXWv7wfITSQtP1gjPeKJaEgmFTZU+d2AYGmM1464ZTXwhWYB82i86m4SNnLbb
         GKFGjnIeSN7nIYWwHOpOvi32pmXk+FO+2blUzos7GUD2Eb5RqZ/dOq/QCv/M41iWr7Re
         5dagc14CKQYQCUbTKxzYzR1uHeE87II+ojBdC03BLJcptWEPw1W1XkmOEJr5z7Cx46LE
         +Gwi4Rs1Z9T+QjlDdhfzY9BcLi5Pt9+qrvAx9poFF1PisVXZLpoWryQKEUSmhzJq/h/h
         d7OQ==
X-Gm-Message-State: AFuF++mEP6ci1Er02RQaqXybCIYQbjAFhUT6ThofLbyBof6Zs1NuR62f
	m1ESvtG1xUsfB05GDYlLgPF8knuQ99/svMwGV4yehq6aZcGk5Ezt+DM5
X-Gm-Gg: AYBFou1y8iVTKHFnY0vf0XCctxmS7kjx20LLrIRm20bVuLnv7at8M11il88bbl2GNXq
	V3W7C1KUonwMndEy2b4jL/R8zHLOViKClm2h4AHgLAcuE+GDtww6QJ2s45pnACRcN1dyGj7u+JA
	EyGoH5i8KDV1gO/qYUbu9YcdlkFXYJf7IUpt0NXicdhFHYzmfwlcYsGe0UVmkPQneHIM+MxQQnk
	pUktEXZUS4yI1liYkVnbMY6yeyk5I4fZISofNQLm6vwt8uyFLhCAzhebZlk6fI3nPxGh7QawQN+
	8T5J9vH5yBLsL43FowNK7dXpuAqK6dFi3Dy5b2FAZ5EfCMA0ZjNvjaQGeQU3k35exnkvx8suNtG
	uWTXhBAF+E+4oUwe60rhQzMqekL/lXHRr+1E3BqCVcpWEUyYyc5OtCjYLqNkYg0iKM7gdOKdFt5
	K6GMG5sZichFsgaYwrEX29hCtXaOs1Uvf4BxR5qnS43+6wwV5ieyHQSeWEo6oP4cIm02iCUQlsS
	NnVB6fhBSCEXy9ENiZ4nuI=
X-Received: by 2002:a05:6a20:7f85:b0:3dd:a195:dd5b with SMTP id adf61e73a8af0-3de9eb40b3bmr1206936637.61.1790771842345;
        Wed, 30 Sep 2026 05:37:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88726c07f4asm738071b3a.59.2026.09.30.05.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 05:37:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 30 Sep 2026 05:37:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] watchdog: core: Restore WDOG_HW_RUNNING if stopping
 watchdog fails
Message-ID: <3dea2f19-d6ff-47c1-9b05-857800287744@roeck-us.net>
References: <20260929134635.2567137-1-linux@roeck-us.net>
 <20260929134635.2567137-6-linux@roeck-us.net>
 <arz4bE9RRKSMQMrf@tzungbi-laptop>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arz4bE9RRKSMQMrf@tzungbi-laptop>

On Wed, Sep 30, 2026 at 07:54:20PM +0800, Tzung-Bi Shih wrote:
> On Tue, Sep 29, 2026 at 06:46:32AM -0700, Guenter Roeck wrote:
> > diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> > index af756ee228b2..edf2cccd1c0e 100644
> > --- a/drivers/watchdog/watchdog_dev.c
> > +++ b/drivers/watchdog/watchdog_dev.c
> > @@ -324,6 +324,8 @@ static int watchdog_stop(struct watchdog_device *wdd)
> >  		clear_bit(WDOG_ACTIVE, &wdd->status);
> >  		watchdog_update_worker(wdd);
> >  		watchdog_hrtimer_pretimeout_stop(wdd);
> > +	} else {
> > +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> >  	}
> 
> This makes more sense to me to move into the block introduced by [1].

Definitely. Thanks!

Guenter
