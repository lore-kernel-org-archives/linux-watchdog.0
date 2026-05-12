Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17425B083
	for <linux-watchdog@vger.kernel.org>; Tue, 12 May 2026 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610675; cv=none; b=a0QZUoRhWTgvDD6XVTzEZ6y23DEWXKSdlywgfpgugtEWZTOiNgoedAhqF/vAW9NXqm3VBMZgxefG1084vpmSgovCmUeEXrNkpibCL+lyw2BWV8lUjAPJ5Yo8zoS0Weqvww2NdN0fg3IH0UCwG7eEghvERVFU2ZeFz8zMSILhf9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610675; c=relaxed/simple;
	bh=5zuVOAfpBrN8nUV5rRh7DAd01oonyphvre94jBBXL/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7eyehzpJCKAjodvRIkERihw6lI4/92otl+K+MV7gqV2+UkPMyJ1y2n4IaWS/PDpAu4PPzH9lHPkaVxKcPeOlLA1OsLFoMrLzdFYIZKkVj4jHK63xMKJ0iTE+V9ReuS5vXQupW8gvY49+8oWiiVEtAej0OrYmli5gNgkJwoVUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiXVSWL8; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiXVSWL8"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1329fc4bf77so1783956c88.1
        for <linux-watchdog@vger.kernel.org>; Tue, 12 May 2026 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778610673; x=1779215473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lbpfqp9eZFaWLOn99BFCizyb8FixFL821MVG82h4o7Q=;
        b=aiXVSWL8VSyEVUm0Zb84PvP/T+73LDnEJkhuQyjGUdgsaK244mKXlQ2TDsW6hibw+W
         c1pPyokadxQlkWsRuS/Wf1RWvJND5EWWfLUZWaeLq4eSq3+twsOh2oKEoKSp06YNv2t3
         L81Hvs09Uo6sKonod6T5FyBsRa6vDWEOGITHciCa4zLfNMj4RdGKdF7KYMAtjf0kEUVK
         u6lJg2JhbWnNPz4+Y6abFXfIk8EO2kPJjVi5iE0zImsZNGLEXqJmB2cga2RJFRedISGb
         /ail0EEESsuMbsCh0UO0CzsUdCdsLG+n3jeEQD5VUBcaEcRrge43tdo1TDyj0CvuuXBe
         1Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610673; x=1779215473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lbpfqp9eZFaWLOn99BFCizyb8FixFL821MVG82h4o7Q=;
        b=r4tI2CiL1IGZnfXq8o+ghZ/zd+QyWNGvkQSWbDtVBA55ZSPh8VZPyW4w0cKOZMXleZ
         ZMUBmLJBJ5728jcRlxquTs9ZKs5H10tm2+d8nwpIQ3wt9aatmGj6zZK6wmsxM8IWRE/v
         eM4CSf17siKUtQVQhfpYtPIZlhkXOcMp+5ZC7Y403Lhl+lXw22ScaGlL0XIGs1pe4VIM
         kUlCeaySdyrJ2hxvBXQvc+Nlg9/XVaIZqjHfSabIgXP7EIjhfZmAeumIIYydOOHiXttS
         GFBLxapQ3wRTSfhWMuvqw+9dnbsv3x5axTtdr3tz+9l/b5bT823N5BcajKYrMiFrj2hb
         /CxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vFahZBh9L0mW6aYGzb7MrE/Q00LXSwX2gM8Zw6KmXKhqH/xFDHVniNPocI+NcqdtetXumBiTfD59Kz+ow8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3BlIPxvTIUruWqJuWMnx5kqx6aKN2uMcIFjGUxIsIQwUToBdw
	4ATkXM8bs3pmfnfn+YbGfD1g8AsLIE/rgg2CgNNd01qjEZDv6RTB1gq29GQCuA==
X-Gm-Gg: Acq92OHxIwsqmlJW7JJ8dKlsm1viiCH/WY6+iAn+Em/zP4O4KGpc7l58gvPXRUIl2yd
	E3nEMuD0jHOwswLQ1tYP7fM846DULVnoAkHLiPDQEwZakjKk0kmiRgRwYwM0GaiCWCuJNCs+Cql
	f5Fq4xU1MCYrZ0DRN2liWH2wigEdORkJeG3d8ECun77Bf8FrjvAYWGtLqwsokSZkeLuyYz7PF6p
	p+OQr3uc2Q9rSso4TFWjHrCn0iYsOynVPClFWYT06RArmZ6Fb+4kLSUP3Y5x0dp3K7TvE3qCwld
	ZF4giZnQRVq8Y0ZKPpr5tuarsPOafiSNxmHlfkwb9AFrJGfkBsOxTSr4gZVJTPbW5du58LV7n9h
	qHqexPBm7DCl/YZJGWYs3aeyFvArJMahC/dV8078bhcSUl84oZDLIq/wSpWDIxH2XyrADPq/MDX
	rNR89RpWia99bzDbdTHXGaNL9AxsX6B1ZSmP46
X-Received: by 2002:a05:7022:1e04:b0:12d:f7a6:e641 with SMTP id a92af1059eb24-13436990c90mr60514c88.25.1778610672620;
        Tue, 12 May 2026 11:31:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278765984sm19827539c88.14.2026.05.12.11.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:31:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 12 May 2026 11:31:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] watchdog: ni903x_wdt: Check ACPI_COMPANION() against
 NULL
Message-ID: <a61ad93f-bfde-4b53-9681-83dc1a895943@roeck-us.net>
References: <2280455.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2280455.irdbgypaU6@rafael.j.wysocki>

On Tue, May 12, 2026 at 06:22:57PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> ni903x_wdt watchdog driver.
> 
> Fixes: d37ec2fbab55 ("watchdog: ni903x_wdt: Convert to a platform driver")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Guenter
