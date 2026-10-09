Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775C33AD8B
	for <linux-watchdog@vger.kernel.org>; Fri,  9 Oct 2026 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555402; cv=none; b=LNC7G9q2HggNKQV8n4YSmHXSFK9W0yvHBJ8Gn1/u3H8cS/N1L/+kpcNo8UBlMWpSXS4x5ZYObAZQR6Hg2NhPUjkyQ4aHay3jWHlyAURKBRJrJ8oKUdlNuWjg+dN6XzCZ4JCL6ln3j9DYVpvortDXU2wNFJ5BnO4yy9t8Aky1QV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555402; c=relaxed/simple;
	bh=zsV905XME2UkBYAIjXilSDaBal3IdIbZsQDMZcjsGWM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YQVOvaSoLR8NAPz2MPvyFweiDhUYpU3wGlSTsNGxs+ty8WigfNsRx+pj4eHkpGjFXgsoOR4E1FFkjpBR1jIibPBJXyi5VsZ3sHbapdIC1qXjdYtN6LuA+LIE8sbs0dL7OZaqVEVs4m9hXF/JZqBBKIfR6joJibXRWMIfP1XienU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TqowhqpH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TqowhqpH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9E8A31A11B8
	for <linux-watchdog@vger.kernel.org>; Fri,  9 Oct 2026 14:16:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 74B6B60754;
	Fri,  9 Oct 2026 14:16:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7709111D70695;
	Fri,  9 Oct 2026 16:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791555394; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+6RbIlULZXUp8nBwvQCiDE791qoyPgtSl8eRr5UTXE0=;
	b=TqowhqpHs1FQoD3nipGC2madeVxQD3oc3Ng2IpD/U/sSYSKZ3g+vnXGZ4KRn4Re6lyQJ+m
	Cp1hBJXMjN8lYN4cARINL6LMT3H0tN/gw3lQr/nkeyna4iwi7cogoExl6UyD88FEFaUwUc
	WPPSs94sl4xDd6cAgg7xKZW8ELFldqi9A72hlZ2M3zcC9thyho/hQ8WfY+zcUs3xwQPYSH
	l/SDzO6rnpa9bNotmiZ7pi2YXR4If2E0981cxs5vI+WltPymbmIObao11ADXhb8bTnbVXj
	7/f+MOesjPFoaqEQCFQe9UgkrT0VtZqVS8FPfCV3K4M/h/K8p7guAcbuq3ATiQ==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 16:16:31 +0200
Message-Id: <DM0DDSTMFXRZ.29S5EXLMD7MHH@bootlin.com>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>, "Guenter Roeck"
 <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 6/6] watchdog: w83627hf_wdt: Report all
 initialization failures in probe
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com> <20261004-w83627hf_wdt-improvements-v3-6-8e27b518595e@bootlin.com> <asUE9eMeey5C42L4@google.com>
In-Reply-To: <asUE9eMeey5C42L4@google.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Oct 6, 2026 at 4:25 PM CEST, Tzung-Bi Shih wrote:
> On Sun, Oct 04, 2026 at 02:12:54PM +0200, Paul Louvel wrote:
>> @@ -549,12 +549,12 @@ static int wdt_probe(struct platform_device *pdev)
>>  		}
>> =20
>>  		if (ret)
>> -			return ret;
>> +			return dev_err_probe(dev, ret, "failed to set watchdog timeout\n");
>>  	}
>> =20
>>  	ret =3D devm_watchdog_register_device(dev, wdd);
>>  	if (ret)
>> -		return ret;
>> +		return dev_err_probe(dev, ret, "failed to register watchdog\n");
>
> Could this patch be split and squashed into the earlier patches in the
> series?

Sure.

Thanks,


--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

