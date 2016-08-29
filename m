Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:52895 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754476AbcH2T45 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 Aug 2016 15:56:57 -0400
Subject: Re: [PATCH v4 6/7] watchdog: pretimeout: add option to select a
 pretimeout governor in runtime
To: Wolfram Sang <wsa@the-dreams.de>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1472227681-1405-7-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160829185441.GE1610@katana>
CC: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <410843e9-23cd-424a-db77-ccf7076aa9d2@mentor.com>
Date: Mon, 29 Aug 2016 22:56:38 +0300
MIME-Version: 1.0
In-Reply-To: <20160829185441.GE1610@katana>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/29/2016 09:54 PM, Wolfram Sang wrote:
>
>> +static struct governor_priv *find_governor_by_name(const char *gov_name)
>> +{
>> +	struct governor_priv *priv;
>> +
>> +	list_for_each_entry(priv, &governor_list, entry)
>> +		if (!strncmp(gov_name, priv->gov->name,
>
> strncmp forces to use 'echo -n' in userspace which can cause confusion
> when if '-n' is forgotten. The cpufreq code pre-parses the buffer with
> sscanf() to eliminate the terminating newline. There is also
> sysfs_streq() which seems the a tad better solution to me.
>

I agree, sysfs_streq() looks like the appropriate choice here.

I will fix it, thank you for review and testing.

--
With best wishes,
Vladimir
