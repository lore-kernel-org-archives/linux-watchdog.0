Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2D3624D4
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507791; cv=none; b=BKjHkLKQCy/OYhEtL/ADUug9NtuZcwVMjV7rM0M9cDEBLq5NSp6QMOGrmVp4a/aWSvBLC3INQq6n0tZ0pwrtTK4JvNYvsilhC0MMirjF47I0xkqxMqFpO/qQOyl0SQMRo3hisYQ77+SYPLXKuvEBJUPLXF5yNW+m13DwcKrQlyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507791; c=relaxed/simple;
	bh=FsNxEQ9zYgrcs77DrRGsPHp6Dw7Br6Di7ET9IvQSP2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT0Fxnsom27uvLfbZlxVRPDKeh0NvrpgMtgr4sjfspRng6hvk4T38q2v4W7t+4nNPm9m1PcLQeYh5qlYaa63QD+AooBq5ra7c6XRC4DjtAozsuR3yL753JvUcNxu2ZFh/Pm0M3iK/H5DdrNtqXtqnNP2fjCgbr9fTAMKwgrQZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO2JyepT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO2JyepT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cab973140bso11941425ad.3
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785507790; x=1786112590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ncKId1czsDRMV8J36ogHF8okZkxS0jzr/V6pUyPO0G4=;
        b=VO2JyepT0bmqVCSPyBLxDEgFiGHwYu/M81xMejh+PI+spiAqgPFuykDL30PhWGecbm
         aNpTSmDl96UfkGJZEQK0pGvX/rxO1DdNROnPphc4QpKKaTfMM9oTSUEWi821ibyVzA3t
         QX+4ZJefX0T4tpgNPc0tQXyTJj3/EmOsmKCZVmC4MbMiiEiU0G1OczMaTEIMdMmU7M8w
         vntmdst9UM4Ztcsa00ex8+1SHjX1muNhYQXWqoHSvOBAv56vCw+zpiDuy0Uw1BlQIiMU
         xe4GHa8EuSxNy5iekoxBsjK9k2IWQswJnXdEAGWV3k9BkkwpsXdEp9BhaFXHI3HzylHa
         0Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507790; x=1786112590;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ncKId1czsDRMV8J36ogHF8okZkxS0jzr/V6pUyPO0G4=;
        b=UU15VUR1MbTxxVfBlQqyN1qiZtQby6AEwXcxR96vp1ri8a5VbzEZx47XbZk0RHiiaC
         e3Vn8s/QjNTntPY7hBkyCfaZ99WsiKaaBfwoCcIb5jOMloffjeBlJTzqOprULt3WH/aK
         j53OyrT++dUssJeZ+HLkgaX2IhDzKvVrP7TtwRoxerxEiWPgtbdEqyPDkdtjDklPZSBF
         /tK5LCoZlXIF1y+K2aAJ0uWsP5i9btX7fQTTO4c03TudcJXdo6NREfcS3zOhOZWtjdKk
         il1MVvALHOojmOMKj0rW9T/qzWRQRRSgS9IwfM6bVW2kGuP+BDL8+EKOUMCYr0xo699l
         Ea6g==
X-Forwarded-Encrypted: i=1; AHgh+RqGjq3iRse5qEDVOBQi0rI4IQYqC/kXycJ0EbJdxRm3zePOvSLpe4P6I1vN+/3vBq6otso9e07f6UhwbCbFYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HOpI8ZJ6dKiF8ur/hC2MU1RQP8MABjtVvT6HAHP3xN0PQGRg
	KiTdpaN24GC2tRvmVkpZIjIIOCWg8VXjLRhnbMe+Ql+0hvzXEHS72bj1
X-Gm-Gg: AR+sD11zXF4XWQDJw1e9YeOjkfH4uuNInzR1qtuarZib4uUqh98QFBJ84vC2u3vq1eh
	9AGiqp3SN3tvXqKqTdU+e7qQujDM0dMZWLDoJ4fxMZhKG+LtRF91aIK3JxXrajTJHVd+HJdBstC
	EtIL2xlLur48HWn+AcOdWwOoOg6PjdOeJX4XpYMXmvRUBoDCMPMLyIQxQszz29uDKy0lY80pKCj
	tiDPg7TD6ketB5dTUkLXYku1qYRX1twlnEuejqwEsjHn5V7s4vKhEQztChy6YyjfdB7Qc6g4O01
	3ouM7nFuITfWP3bJ2ojDyNiXcj7RjxNWjm6OJZpkWtDfJ7Y+0hagyuD2UHMzAf+MbD9jGp4KAiq
	VH1jwzxDkZrmwKChIWHGqwEKo5X8f82H0C5pfLxm63U+rshXS8euRJjzDEPE1/gEjaF0taSaY5Z
	Z6lPoFrcyyZTRMAEc38kzb/vRTSGxLZOqFpZWXQjBcxeHTOc3hzWWo6CXl7wSVeZUVnhIfbHH9Y
	Q==
X-Received: by 2002:a17:902:cf43:b0:2cc:f7c6:834e with SMTP id d9443c01a7336-2d0523c030dmr2199335ad.32.1785507789702;
        Fri, 31 Jul 2026 07:23:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b120d98sm6045965ad.59.2026.07.31.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:23:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 31 Jul 2026 07:23:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] watchdog: qcom: report WDIOF_POWERUNDER in bootstatus
Message-ID: <7bbe163b-3226-4516-b8c5-d3cabceea426@roeck-us.net>
References: <20260728-qcom_wdt_powerunder-v1-0-de8d9e964e7d@oss.qualcomm.com>
 <20260728-qcom_wdt_powerunder-v1-1-de8d9e964e7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-qcom_wdt_powerunder-v1-1-de8d9e964e7d@oss.qualcomm.com>

On Tue, Jul 28, 2026 at 04:28:02PM +0530, Kathiravan Thirumoorthy wrote:
> On IPQ platforms, identify the restart reason as POWERUNDER, similar to
> CARDRESET, and expose it via the bootstatus sysfs interface.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Applied.

Thanks,
Guenter
