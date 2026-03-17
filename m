Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6D1D61B7
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Mar 2026 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760386; cv=none; b=E6vdNooxR4vdLHNLntgF4DymH9Av6QzG6KZmkIJXfcwKQQaQs39LNGvcIHsw1xjHB3Kv13wRKh7u/+jfEtec/ZHCCGPuU9Byrh2Rqn/NeE+GUURR1TLjCTCJohh1iHUkYvA9+qeLPy0H2aHG/GxPT3TKzI+fJjzu1jM0YYDn2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760386; c=relaxed/simple;
	bh=VGRJAgcHYFUT842aOltJumuFGMsP3ePD1gLSvxiESKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8L0odtONO02XWxayZTO+U/OuuB6qjyJUjCeY8uk5hi9D9QB4y5J5UzODCfGayL7l3MDo1poe0V8AZ90iM5OLDiOAu6BFLEfWlYPUO0n9PBovCMRll2r0zHs+TslM1EzgqAzQcgI76cwEAUxfPp71I3jJ7XRHnun/DP58YR0muw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOHruMEA; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOHruMEA"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-128ebee22caso3755682c88.0
        for <linux-watchdog@vger.kernel.org>; Tue, 17 Mar 2026 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773760384; x=1774365184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DTUIDlVZgG+FukAGH8YDShJmvechRFPdqthLgNdv2m8=;
        b=bOHruMEAfWmBc6P+JJEyd/oWIYWIpVxe69S5+qEZj7nv/KngiWD19crPfjTHGSepFr
         ofJPDV5GcANFuPt++RFETWDwGmpvLJc0ithNXoozbBMiC/LcpwccfBg/+X/QVMIonGjM
         rj6VcmtIyeXCCZFjiSJIBymYhiDyCTE4+STTKzj5at0fz7pTEtr6UYNtZvU40LCy5PRX
         tA9ZWkYN0jfQKzeoSW/eQCEPQnczbwdhijiOfI1zGwx3f3CYbUrlE8FqR85EVvrDoCI9
         ZXpvVbh2B2x1gDMOP6bxmFd1HcxZkJKChe54+KLHcL2m1I4cohr4DB9xZWf+VO/eNFtN
         k9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760384; x=1774365184;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTUIDlVZgG+FukAGH8YDShJmvechRFPdqthLgNdv2m8=;
        b=E74KqO5mE6cV8F319898oS09xTRfZEjpnW2ZvPsubg5o2rIOHze9TMBI/kVdWQH/EI
         1HpZePw1dmWvF7KFr5moxLdXXZJDJzwGSc2rS/3k0wP1kxQ3OsUvYwXpExsG3h20WhBd
         9TYTztLJipToZoDVkKH2d3lYR+NNpGSShX0xeedwPH77GJuRGgej+8X1vgBpW8yqsZq7
         h+4sEGh17NAtO7N2IeBammbah4//yqp/+o/1P1bMK/oEPuTc6nWK852Aee1FihvXBqRU
         33dViMXJBT2MkoRE7P0KWNteN8kFRHEJNrkzrdmTuNm/01HS/YFpyG+VJWf9phpUXtdg
         3soQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkoGMJOfm6MalTUIi0o6jzUh42S/3XH41Cz4pvABUL19uOgT/rkH16GOiYYWqp5fQCwQBeqFHYwTKmbwNkKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVqJMoWaW9x/VGg39MFs3Uj9Ft6aR9rxDxHNJFI8MQAveHcFq
	YtjXu68GT5AYp9w/30kAzlH3GROkzz2EQu9dzYJm8hzmsHAiviQS9HTS
X-Gm-Gg: ATEYQzzJxkre+ivYZMfBa86PvWumFzIf4poQ/Av21S+WHgKBbjDYMf5JtBl9tf1AKx6
	VRx1+vYiIp8jTqpjPCIZdFCdKbyT4yUb6P60JLmKtpfTkOfdiXbSOy643PW27t0kHqV5YcteMLn
	vf6gPWiTr0EX9S2MjbKL266ov1/InpFm3TkronmwOouJ5RYnHEs7JYRRwIfPP9ZvCB0ZAOWEUeB
	FssQmTw1JQCDRazOVRXnGcNGejwBcsXUfHDfnnt5eQMfe9l4b8eIEAYDfjThmSMudCk0+733vRA
	atOaQx+wVNh0u23aqit49PQrcVyBO591+y+7nrq8XgSUCliySXUH2KaXUdrn9OTHjcsbB2W755r
	NAggVXZQdFr5LjaMLxjHEmGtW5j+ONygvp9c6Q6aI1eh4CQb7j0YtIhfRPgnfVcByCGqUIowwGp
	bLv6+A0fFfpQHuO33utloeXB0wca8bhjCz5LBrZX2KgY/rJeG7dNhUcrVAKbBj0+BkbZOuthfwA
	NX0JRfC+uk=
X-Received: by 2002:a05:7022:3a04:b0:129:ea3:8d64 with SMTP id a92af1059eb24-1290ea3b091mr3629025c88.41.1773760383971;
        Tue, 17 Mar 2026 08:13:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62b2100sm15333034c88.8.2026.03.17.08.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 08:13:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b8c1319a-4920-42b8-b98d-248e419cb87f@roeck-us.net>
Date: Tue, 17 Mar 2026 08:13:02 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] watchdog: ni903x_wdt: Convert to a platform driver
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-watchdog@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
References: <13996583.uLZWGnKmhe@rafael.j.wysocki>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <13996583.uLZWGnKmhe@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/26 04:53, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> In particular, registering a watchdog device under a struct acpi_device
> is questionable because it causes the watchdog to be hidden in the ACPI
> bus sysfs hierarchy and it goes against the general rule that a struct
> acpi_device can only be a parent of another struct acpi_device.
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the ni903x_wdt watchdog ACPI driver to a
> platform one.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
> 
> Note that after this change it actually makes sense to look for
> the "timeout-sec" property via device_property_read_u32() under the
> device passed to watchdog_init_timeout() because it has an fwnode
> handle (unlike a struct acpi_device which is an fwnode itself).
> 
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/ni903x_wdt.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/ni903x_wdt.c b/drivers/watchdog/ni903x_wdt.c
> index 045bb72d9a43..8b1b9baa914e 100644
> --- a/drivers/watchdog/ni903x_wdt.c
> +++ b/drivers/watchdog/ni903x_wdt.c
> @@ -8,6 +8,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/module.h>
> +#include <linux/platform_device.h>
>   #include <linux/watchdog.h>
>   
>   #define NIWD_CONTROL	0x01
> @@ -177,9 +178,9 @@ static const struct watchdog_ops ni903x_wdd_ops = {
>   	.get_timeleft = ni903x_wdd_get_timeleft,
>   };
>   
> -static int ni903x_acpi_add(struct acpi_device *device)
> +static int ni903x_acpi_probe(struct platform_device *pdev)
>   {
> -	struct device *dev = &device->dev;
> +	struct device *dev = &pdev->dev;
>   	struct watchdog_device *wdd;
>   	struct ni903x_wdt *wdt;
>   	acpi_status status;
> @@ -189,10 +190,10 @@ static int ni903x_acpi_add(struct acpi_device *device)
>   	if (!wdt)
>   		return -ENOMEM;
>   
> -	device->driver_data = wdt;
> +	platform_set_drvdata(pdev, wdt);
>   	wdt->dev = dev;
>   
> -	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +	status = acpi_walk_resources(ACPI_HANDLE(dev), METHOD_NAME__CRS,
>   				     ni903x_resources, wdt);
>   	if (ACPI_FAILURE(status) || wdt->io_base == 0) {
>   		dev_err(dev, "failed to get resources\n");
> @@ -224,9 +225,9 @@ static int ni903x_acpi_add(struct acpi_device *device)
>   	return 0;
>   }
>   
> -static void ni903x_acpi_remove(struct acpi_device *device)
> +static void ni903x_acpi_remove(struct platform_device *pdev)
>   {
> -	struct ni903x_wdt *wdt = acpi_driver_data(device);
> +	struct ni903x_wdt *wdt = platform_get_drvdata(pdev);
>   
>   	ni903x_wdd_stop(&wdt->wdd);
>   	watchdog_unregister_device(&wdt->wdd);
> @@ -238,16 +239,16 @@ static const struct acpi_device_id ni903x_device_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(acpi, ni903x_device_ids);
>   
> -static struct acpi_driver ni903x_acpi_driver = {
> -	.name = NIWD_NAME,
> -	.ids = ni903x_device_ids,
> -	.ops = {
> -		.add = ni903x_acpi_add,
> -		.remove = ni903x_acpi_remove,
> +static struct platform_driver ni903x_acpi_driver = {
> +	.probe = ni903x_acpi_probe,
> +	.remove = ni903x_acpi_remove,
> +	.driver = {
> +		.name = NIWD_NAME,
> +		.acpi_match_table = ni903x_device_ids,
>   	},
>   };
>   
> -module_acpi_driver(ni903x_acpi_driver);
> +module_platform_driver(ni903x_acpi_driver);
>   
>   MODULE_DESCRIPTION("NI 903x Watchdog");
>   MODULE_AUTHOR("Jeff Westfahl <jeff.westfahl@ni.com>");

