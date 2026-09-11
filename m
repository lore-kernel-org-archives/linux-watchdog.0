Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652F3B8413
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789097978; cv=none; b=SYvROBTuL7sAb404fudrt67hgpKKJIi8Cww2Zz7OSSFbAOQcl+YmnvfZYzofA7g6Rv+M+y7Sm2R3zMefdmGEKnpuU6ufW6cmuYWv7ggWp2nS3A79NECYe4xx2gPcm/VUkOsocC35Ki2bvq+j0fa8ZZHOl8tKfr/n3bvYhDUUy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789097978; c=relaxed/simple;
	bh=FJFGlGVdbeEyeBDWM5Qw+xmK9I5Y0Ls7Z5bdMUMJoJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFRvJOsxyYROTDIyS4sgpYG+wmyRH/4wMYCpGYtqaWZE17syZ2Bj+yAcFHvHi8nxHqPGdApyXU9b+p8wmgpnfagiEpqF0kVDK/opb0JVuwcXJrzjY/kCAWFiD+xDNGKPkzfbu+yUvypk7w2xSP3+H1NPWxOt2b0pTQOOHkQIf9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwo75oGg; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwo75oGg"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25400so273766b3a.0
        for <linux-watchdog@vger.kernel.org>; Thu, 10 Sep 2026 20:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789097976; x=1789702776; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JozBrHAJqyNEU4Ya07gtANtKW5o1JFbZSNqDARQkvO4=;
        b=rwo75oGgkoVWyBhphBAjoHFm0uPS9eRhb1SW4HbaCYwA21Ea6tI/VnGGyjX79irwGF
         tNNhAGbF04QTc9gvlwGQQ6O7EIWqueB58gUMDd8weB+F3yETB0FBwizopKk1pK15tC+9
         hcqKxHQj8VPNtjiMNOYnHKQ/Jx644CgSi891MExryap+FBYDxDzjWu/O1CIF2EIsh/kM
         X1Uj+7DXG0kSjndYcK6gStr1ApAI3HJzgXzkaSXhrFWIYL8SsPdQ0QnRI4jMjLRqp4i/
         Z4BpXyjseWwYog5vnpCrTO+/6fT2KXsgkaaQDwBZmB1RSfL7OLbP5fJXB/BzylIRy0/5
         fcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789097976; x=1789702776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JozBrHAJqyNEU4Ya07gtANtKW5o1JFbZSNqDARQkvO4=;
        b=cMy76bwHcjTZ3nBJHFOAc//Q9oWxFSpfAcEzg/UJqgVWsztYqA9ZHEo8On+swpmVYv
         FMEhJFP6jFKXwPaXW4br4S91cwquGTWkkvng9aINULrg5ZhNqsI9Ed1AA7DGjrkR6qF5
         51FpmFXyt/wVv/mjKg6rHqbiUWDKea24sHp5m7++TSfrmFthmAv2KDkJzAipI6mfzy3E
         90dwh1xveGsjJToYZrCQHFi5TMg6jQMm9Ys/clZYwV9QfQu6CnPXBln+wjRmWa9gp0Wv
         /7s6WCnAKL/ftDntSr2pAykFrHe5IF4r7JVAsACuqrsAf0X+zBYL3oBlxjvhGRBx5oXy
         eQkA==
X-Forwarded-Encrypted: i=1; AKwUvBwCOA1bMgye59S9EFrhWflBieQuQXwQsjLargvmMRfDzRWUGuwgq8eOah3U5SkOzSHfQGHJqSQWybw9EkcReQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lur8lV8A0yscYr7kB2OyigT/28pYY2tE/CSyOHMnpiuP2Ucy6Q
	5oEWYmMKI78CQZMtuuGsWg4gywAvqnbg74uLFjVlI6xxoZkLy5sPUIO/
X-Gm-Gg: AYBFou11L+abyW+ll2wtD8CDQ/k3KZHPkX6cRijSyW1+iR+FyQSVb/0KXoz8SP6alD9
	cD+FBhRdFzhqKGpjgp9aF8eF29gM+NyKohCzMrC06YeGqeOLTifI8CsEfdKyQ0jI0OuG67gz/7X
	7e9T+c7T9RNbkAjnkxNAkKly0edYF+lNfemf1efcOYIw/DeDWBYDxmTSMQIH/131et4VmDMgSlN
	kKDxdmqTLfWd8S345JXTiK5XlYt4ijUgHMcfIlV7oUqAvSrra7WB2C0V8CIE4+uyf/NiFn1nfeV
	3zvF/iV6n1F8JtJWIq2QWZLhe7JCyoA79wwi8DUzg8UNNWA5KcmYbAPmXmqNdI4fN51LEUIEdDk
	OftDrZglTJC1goAtoitfLc61Q1MOhEeyQj2OddYgTsFXp7K1ncy8kgk79icXN4WLMA3CsWNQJ1h
	BLssBUtCbJaJPV2kNSveMPFn/S5VhuYgqOcWJxjSysvbwuRaMP7ukgYr8YI3/4oXyfzraXn65Ip
	q67Ls3XZrOE
X-Received: by 2002:a17:902:f60e:b0:2d9:33d4:a910 with SMTP id d9443c01a7336-2dd2a1d526amr56647575ad.4.1789097976509;
        Thu, 10 Sep 2026 20:39:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd94easm4310465ad.63.2026.09.10.20.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:39:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 10 Sep 2026 20:39:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Li Jun <lijun01@kylinos.cn>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: sp805_wdt: fix suspend/resume handling of
 HW_RUNNING watchdog
Message-ID: <6f6c82e7-74eb-40d9-a277-2ecbdfa02b14@roeck-us.net>
References: <20260911030531.837140-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911030531.837140-1-lijun01@kylinos.cn>

On Fri, Sep 11, 2026 at 11:05:31AM +0800, Li Jun wrote:
> sp805_wdt_suspend() and sp805_wdt_resume() only check watchdog_active(),
> when the watchdog is left running by the driver sets
> WDOG_HW_RUNNING in sp805_wdt_probe() but userspace never opens the
> device, so WDOG_ACTIVE remains cleared, the wdt_disable() will not be
> executed in sp805_wdt_suspend. In this case, the suspend callback is
> a no-op and the watchdog keeps counting during system suspend,
> leading to an unexpected system reset.
> Check WDOG_HW_RUNNING and wdt->wdd，can fix this issue.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Applied.

Thanks,
Guenter
