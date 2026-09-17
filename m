Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D3931B130
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604764; cv=none; b=TgOXh5BVV2eOMSe8YCRAvBMx85FcNRWJvTrOEo4ACrYZKYtZuVkbcIVY1xynq2wAZ0BQBxbaXKR9pwRY6ociM7Pamxo2CIJFy2ztxzobd2CxjFoItKhyup/lUl/aWdwaglqK8qndfKYVSt7MiWH2c3YjK3YweX6JYIUulQCD6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604764; c=relaxed/simple;
	bh=5b/u82wL27/Fu9PH2a97FNdOABh4pOizTMteEoxSlJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSA+4pDlKVnWbmcL22UfS8MD//cWTAeBc6Gw1MEVSdsM/8b3d/3ShJr/P2an7FaX1iXRI80K1q7U5Vx139tzTQG1wcf7mltHG2xPdZHbYVQac7BO8h9PVYtYW3389iebmEW8Xai+AxsslEvYN+H3xkm4DE7SqqLeKmPVo6hfszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7IQBgPL; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7IQBgPL"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d249c5so193565b3a.3
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789604762; x=1790209562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vV88gSyI1c3ZYT2h6e0lSF5RM8fB6PlCcIwJXe36LlM=;
        b=j7IQBgPLjn9sH0nV2YvmCk6T2O2+TXlNsEyPEGYiRAwXEDeUO4+RwOQLwZnua0Bgk+
         oO4B1NnOarcDEGX5DywGc7yhbfC/15WtUOrEIvt8iGp9pJq7p4RXMITE0onw3QS3zoo0
         8X+xPaA/cKJk5OVZX6Z/SzS2J+mUMUHI93b70jbiMsbuzSCVDrzy3hrVbceTBaJfVO4C
         rsWKGiYiJUl6oLibqw8Mbbe5Xg/9beBxjp3Np5KHkItCZ9C36gKe86M2GPkMPwvgPbOM
         BX3uJIShx5bfXFvg6XLIbO2Wh2HxmU+8KDrDZLIX8i/6/RM1VRYs+j68uuIN97ZJHkJA
         tncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789604762; x=1790209562;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vV88gSyI1c3ZYT2h6e0lSF5RM8fB6PlCcIwJXe36LlM=;
        b=22mCDJrBwzR2bULhm9SbZisHG85kB9CcJj+WBdMzoBD2sz3N5xKB2m7Ra6hPMrG2gd
         4Q6SoK8k3yESOURigKDWQINcJNH3uKfju9pmBdYkuzzHmKI0C0fHk63ay/Gta5FaK6d4
         6EcX3estNrF4Ews3LTFsE44/Stv3akff2E1U+BVskKK19/yL2tFC7bz76MUWGLz6RBPo
         ioyMEHeP1MUnV/pzmAAgsAl5r5S3URVbeTF2B82Cr50XpdnfrldXVVZ5S7ESkDhuRtPo
         Dvp5pIvyDVVn4Ai/yuPzHMf0qIUVbqjoLfSUlpb4cXSFHSI+naih6kpUUzMfIyYznia+
         7Tug==
X-Forwarded-Encrypted: i=1; AKwUvByfu4jEqjiE5VK1b1l9rcvcebNI0z9A5JGJV/aVDv7tWWdH22UuJ4Ob6LslN0DIQ4vpWetdGrLlvOQty3rR3Q==@vger.kernel.org
X-Gm-Message-State: AFuF++nMtDoLZ//cpjX/Jv1Ux1iRyD/vX/xw4pFed6cY1F/K77cUOgUA
	F4M3t+8PdlvVX/mIPtnm4tvOPK17nx8ZdTPuAD5ZWywLAVSC9kktm3eR
X-Gm-Gg: AYBFou1tJ7h15HVGmuQLlMWRRVyDmOKfcFqJ45CV3COfnyU3ilBqdTmuxI65GCzMqT9
	x4RpXcXdSH09u3r/kyUjd8E0XjADN3LO+0v7NDJfqAPCNxIFlous+GDraiGWiezlVKd4tkNnKUi
	Sqf5IqytJjc1VLTHld1b3laULMmzauYOp+01V1iaU6zEp1NMJbr5EW3rdFwJ08gyAukMSL6dvt8
	UpZCjIbTdwrwQm2drIXQcnjv6d0A9unIvfy9cUVJPsEFYLWr6Of9mhOOVgYZrcOY78z3EJE+A0a
	UNm0o20hjNpMtDez55ZDo6LPFuroYjmEoEJJjDMbrmeHDuJBJE7xfHb8fxZCzrV6TY20DxN+k+o
	iIbOlDeZJWK6DNe7PVfAJxCp2ji+a6XI3UNp8KE7dfMEoUjwKlJfev4z6rc8yAZl1S6c062+0MZ
	f+NQfTzb6HuO/y1a/yciGJzA1tVU1XkKcsiggxWuQFVxuqMmYq0/sfU9cB7UBsvh6xgGGwukNMX
	BeAYlU0ffSJ
X-Received: by 2002:a05:6a00:440a:b0:870:c2db:da40 with SMTP id d2e1a72fcca58-87239a9dce3mr9776123b3a.24.1789604761569;
        Wed, 16 Sep 2026 17:26:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872025dd04csm1926956b3a.60.2026.09.16.17.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:26:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 17:26:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	mikew@google.com, priyankag@google.com, wim@linux-watchdog.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: sp5100_tco: Fix pci_dev reference leak in
 sp5100_tco_init()
Message-ID: <8df16733-9a20-45eb-89b5-c396244f0062@roeck-us.net>
References: <20260916170511.2086199-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916170511.2086199-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 05:05:11PM +0000, Wentao Liang wrote:
> sp5100_tco_init() stores the PCI device matched by for_each_pci_dev()
> in the global sp5100_tco_pci and keeps its reference for the lifetime
> of the driver, but neither sp5100_tco_exit() nor the error paths of
> sp5100_tco_init() call pci_dev_put(), leaking the reference on driver
> registration failure and on every module load/unload cycle.
> 
> Drop the reference when the platform driver or device registration
> fails and when the module is unloaded.
> 
> Fixes: 15e28bf13008 ("watchdog: Add support for sp5100 chipset TCO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Applied.

Thanks,
Guenter
