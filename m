Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF3318BB8
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604881; cv=none; b=ldmriejfr0gUqRr/BEYq9mbe4ehJ19oZKT/EPhUGlU/gN0qc0obyEd5FYD48/2+Z5HXyAdQ8hGn2x6ZcpCWmhY1LcpOPWBGAtH9b54Xt6JjJwkxMlLdNuGu11b0mL+AIZTGQSLjf3oebZzdkAmOh0QqU8nqQvx2WxS4XZRr5DXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604881; c=relaxed/simple;
	bh=9FgMLbEt/sXyQcNribkC7l0KNZOAkXosmxtmyUflEYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhcjg1Tkp8yWedbp16bEZORDOovxK6Pm7DoGgxNgTuXyHttgAeMwI8O1bbHbbC3bdEPGX8+Qmzqm5s+EAR7MKd06wrmKXG8NxZVpCEvqw4XyHB2MtWxI28VJl46NVsTmUXM0letDvvB6wq8y75LWv4rio+I0QeZkYCoU52qu/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJgeciLe; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJgeciLe"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so198660a91.3
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 17:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789604879; x=1790209679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tmkJQLUc+UOHMTg0w7B4y5XSpy6y1Yvw1LbiiPABaEo=;
        b=LJgeciLe213JjUYHt1ofecbn/A0QICj3sI4Xcr76xpr9KnAA9yGD2ZY4LgytAmHF5T
         E0sWivnTFtWTDIjoQy5Qm70xJH4BPaFVVXGd5knukxtVw2ClRfrd2TAloLhOmSAR4TJ8
         0Jae5x0nZ67xscwzRQnUS39//zS7JD9agVjEYWvRVSVxq8gox5RZ6KuHiKUtvyGcGRT1
         dIWleeQzt+q88bwFTanW6v8QOzrARjHe16QfuV/6j4pT4TqywMZg8STcswFDtRudkOnL
         0jbMuWOBCSDYwr4xdX9cPgp+9oS/STjsvbIIOcTS74FILHAnARO0DP1wNmOauVsrYou1
         W24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789604879; x=1790209679;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tmkJQLUc+UOHMTg0w7B4y5XSpy6y1Yvw1LbiiPABaEo=;
        b=Ee1u7RnSkjw3IYeghV/aw/2c/ujOghWQ2r7UcWaBSNLVdf5mIjP1AQuIhlmTTiHPor
         1Hr0OdQ2+coPirqGBfkGIDAqsgHjq8HnxbSLA+MVazuCtn9df/6nSiQyKKX75IrroIoO
         B+UJtaO3JROZNPzTa5gvRiEojQJ2iDI9USqo0SLpazldAQ1tcL6mWG8+qdfif3ENZSfW
         XEnr/gXaQykN5xDjAG7BZqrwnjIaoIpXIr74vLZ8aECA3k4cknG0nBVt5+/WlcO6WMcv
         TnlwFHFZCnk1FVXIfj3alCa99HP7WPfg867a1JTp+SnXEtqIV2hBNT00lbxfhBIy7r+U
         uy6g==
X-Forwarded-Encrypted: i=1; AKwUvBxKXQNmq4i+XlZ/whSZgY7SzExWae2EgL05caaig9kr4bKcomuNSPWqR91zWrJ5nu7gF6c2ndVvSBx0eD319Q==@vger.kernel.org
X-Gm-Message-State: AFuF++nSBCnkmb4kW3zGPsP9beviUXRAD02t514YcUspH/3dyAVRlBpc
	yU7USqZPDdMbJXKazA43CTCfUs2/IfToRFU4pMiPQ6MM1eaOTIhq7gRv
X-Gm-Gg: AYBFou24aC9FwVQWBsf56v2OrQOs8uKIxy76cPjwzWc0sbFdGN8s94A6oSft+XbrPOU
	y+qA9g5eHco4milOOkT5DRbpfR7tVrVzSUaCyDSZtXjX5aDa06/oYuCVgfqTDPOZWpp6Pmia+AN
	wyknrDJchxbdztXVPbpCMbzuDRIn+zIJckdCs3Nn6Qgj99SOW/8SgoPMtfDUbvvgJL6HEXbRxzW
	0oIK1p1b6tb8U+KExIUcN6c00VQrHdqb1aiAqJM0D7ehDzpIPL94lr7zWVCm3lzAAL/5doPh1r8
	AyXFIoUVSaFUTqsebl/+LCApVFlH6AAWH7hwE4qiyKufcQPHwUCih0rPnFcsEX8S6gi7jHtme0g
	4zfgD4xp2PhqBA8ZeInlDdiFuJBgcxgR2sA0cRJdzEBfIYzZe7nV6nSIrEuXW/QXOaXDL7TI1sy
	BvcOcrEuAXPjVohW6tvzsO8fhlyN/7FyRBnfVIwUjClEknOxUzIak8oXtGGXaT44OrXX3Q+yCqz
	t5b0lex7w5JzyOSyxcM5b1H
X-Received: by 2002:a17:90b:3842:b0:39e:3ce1:d22f with SMTP id 98e67ed59e1d1-39e3ce1d970mr721394a91.16.1789604879311;
        Wed, 16 Sep 2026 17:27:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3617443asm1948689a91.9.2026.09.16.17.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:27:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 17:27:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Baruch Siach <baruch@tkos.co.il>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: rtd119x: Avoid division by zero
Message-ID: <dc85b026-c81f-4b41-98a6-e6ef842c20eb@roeck-us.net>
References: <20260913064851.8239-1-tzungbi@kernel.org>
 <20260913064851.8239-3-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913064851.8239-3-tzungbi@kernel.org>

On Sun, Sep 13, 2026 at 02:48:50PM +0800, Tzung-Bi Shih wrote:
> clk_get_rate() could return 0.  Avoid a division by zero panic.
> 
> Fixes: 2bdf6acbfead ("watchdog: Add Realtek RTD1295")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Thanks,
Guenter
